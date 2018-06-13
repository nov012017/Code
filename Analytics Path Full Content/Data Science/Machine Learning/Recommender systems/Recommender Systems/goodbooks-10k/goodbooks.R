# Read the dataset
# Load the libraries

install.packages('tidyr')
install.packages('DT')
install.packages('knitr')
install.packages('gridExtra')
install.packages('corrplot')
install.packages('qgraph')


library(recommenderlab)
library(data.table)
library(dplyr)
library(tidyr)
library(ggplot2)
library(stringr)
library(DT)
library(knitr)
library(grid)
library(gridExtra)
library(corrplot)
library(qgraph)
library(methods)
library(Matrix)

books <- fread('books.csv')
ratings <- fread('ratings.csv')
book_tags <- fread('book_tags.csv')
tags <- fread('tags.csv')

# Clean the dataset
# Remove the duplicate ratings

ratings[, N := .N, .(user_id, book_id)]
cat('Number of duplicate ratings: ', nrow(ratings[N > 1]))
ratings <- ratings[N == 1]

# Remove users who rated fewer than 3 books

ratings[, N := .N, .(user_id)]
cat('Number of users who rated fewer than 3 books: ', uniqueN(ratings[N <= 2, user_id]))
ratings <- ratings[N > 2]

# Select a subset of users (to reduce calculation time)

set.seed(1)
user_fraction <- 0.2
users <- unique(ratings$user_id)
sample_users <- sample(users, round(user_fraction * length(users)))

cat('Number of ratings (before): ', nrow(ratings))

ratings <- ratings[user_id %in% sample_users]
cat('Number of ratings (after): ', nrow(ratings))

# What is the distribution of ratings?

ratings %>% 
  ggplot(aes(x = rating, fill = factor(rating))) +
  geom_bar(color = "grey20") + scale_fill_brewer(palette = "YlGnBu") + guides(fill = FALSE)

# Number of ratings per user

ratings %>% 
  group_by(user_id) %>% 
  summarize(number_of_ratings_per_user = n()) %>% 
  ggplot(aes(number_of_ratings_per_user)) + 
  geom_bar(fill = "cadetblue3", color = "grey20") + coord_cartesian(c(3, 50))

# Distribution of mean user ratings

ratings %>% 
  group_by(user_id) %>% 
  summarize(mean_user_rating = mean(rating)) %>% 
  ggplot(aes(mean_user_rating)) +
  geom_histogram(fill = "cadetblue3", color = "grey20")

# Number of ratings per book

ratings %>% 
  group_by(book_id) %>% 
  summarize(number_of_ratings_per_book = n()) %>% 
  ggplot(aes(number_of_ratings_per_book)) + 
  geom_bar(fill = "orange", color = "grey20", width = 1) + coord_cartesian(c(0,40))

# Distribution of mean book ratings

ratings %>% 
  group_by(book_id) %>% 
  summarize(mean_book_rating = mean(rating)) %>% 
  ggplot(aes(mean_book_rating)) + geom_histogram(fill = "orange", color = "grey20") + coord_cartesian(c(1,5))

# Distribution of Genres

genres <- str_to_lower(c("Art", "Biography", "Business", "Chick Lit", "Children's", "Christian", "Classics", "Comics", "Contemporary", "Cookbooks", "Crime", "Ebooks", "Fantasy", "Fiction", "Gay and Lesbian", "Graphic Novels", "Historical Fiction", "History", "Horror", "Humor and Comedy", "Manga", "Memoir", "Music", "Mystery", "Nonfiction", "Paranormal", "Philosophy", "Poetry", "Psychology", "Religion", "Romance", "Science", "Science Fiction", "Self Help", "Suspense", "Spirituality", "Sports", "Thriller", "Travel", "Young Adult"))

exclude_genres <- c("fiction", "nonfiction", "ebooks", "contemporary")
genres <- setdiff(genres, exclude_genres)

available_genres <- genres[str_to_lower(genres) %in% tags$tag_name]
available_tags <- tags$tag_id[match(available_genres, tags$tag_name)]

tmp <- book_tags %>% 
  filter(tag_id %in% available_tags) %>% 
  group_by(tag_id) %>%
  summarize(n = n()) %>%
  ungroup() %>%
  mutate(sumN = sum(n), percentage = n / sumN) %>%
  arrange(-percentage) %>%
  left_join(tags, by = "tag_id")

tmp %>% 
  ggplot(aes(reorder(tag_name, percentage), percentage, fill = percentage)) + 
  geom_bar(stat = "identity") + coord_flip() + scale_fill_distiller(palette = 'YlOrRd') + labs(y = 'Percentage', x = 'Genre')

# Different Languages

p1 <- books %>% 
  mutate(language = factor(language_code)) %>% 
  group_by(language) %>% 
  summarize(number_of_books = n()) %>% 
  arrange(-number_of_books) %>% 
  ggplot(aes(reorder(language, number_of_books), number_of_books, fill = reorder(language, number_of_books))) +
  geom_bar(stat = "identity", color = "grey20", size = 0.35) + coord_flip() +
  labs(x = "language", title = "english included") + guides(fill = FALSE)

p2 <- books %>% 
  mutate(language = factor(language_code)) %>% 
  filter(!language %in% c("en-US", "en-GB", "eng", "en-CA", "")) %>% 
  group_by(language) %>% 
  summarize(number_of_books = n()) %>% 
  arrange(-number_of_books) %>% 
  ggplot(aes(reorder(language, number_of_books), number_of_books, fill = reorder(language, number_of_books))) +
  geom_bar(stat = "identity", color = "grey20", size = 0.35) + coord_flip() +
  labs(x = "", title = "english excluded") + guides(fill = FALSE)

grid.arrange(p1,p2, ncol=2)

# Top 10 rated books

books %>% 
  mutate(image = paste0('<img src="', small_image_url, '"></img>')) %>% 
  arrange(-average_rating) %>% 
  top_n(10,wt = average_rating) %>% 
  select(image, title, ratings_count, average_rating) %>% 
  datatable(class = "nowrap hover row-border", escape = FALSE, options = list(dom = 't',scrollX = TRUE, autoWidth = TRUE))

# Top 10 popular books

books %>% 
  mutate(image = paste0('<img src="', small_image_url, '"></img>')) %>% 
  arrange(-ratings_count) %>% 
  top_n(10,wt = ratings_count) %>% 
  select(image, title, ratings_count, average_rating) %>% 
  datatable(class = "nowrap hover row-border", escape = FALSE, options = list(dom = 't',scrollX = TRUE, autoWidth = TRUE))

# What influences a book's rating?

tmp <- books %>% 
  select(one_of(c("books_count","original_publication_year","ratings_count", "work_ratings_count", "work_text_reviews_count", "average_rating"))) %>% 
  as.matrix()

corrplot(cor(tmp, use = 'pairwise.complete.obs'), type = "lower")

# Is there a relationship between the number of ratings and the average rating?

get_cor <- function(df){
  m <- cor(df$x,df$y, use="pairwise.complete.obs");
  eq <- substitute(italic(r) == cor, list(cor = format(m, digits = 2)))
  as.character(as.expression(eq));                 
}

books %>% 
  filter(ratings_count < 1e+5) %>% 
  ggplot(aes(ratings_count, average_rating)) + stat_bin_hex(bins = 50) + scale_fill_distiller(palette = "Spectral") + 
  stat_smooth(method = "lm", color = "orchid", size = 2) +
  annotate("text", x = 85000, y = 2.7, label = get_cor(data.frame(x = books$ratings_count, y = books$average_rating)), parse = TRUE, color = "orchid", size = 7)

# install.packages('hexbin')
library(hexbin) 

# Multiple editions of each book

books %>% filter(books_count <= 500) %>% ggplot(aes(books_count, average_rating)) + stat_bin_hex(bins = 50) + scale_fill_distiller(palette = "Spectral") + 
  stat_smooth(method = "lm", color = "orchid", size = 2) +
  annotate("text", x = 400, y = 2.7, label = get_cor(data.frame(x = books$books_count, y = books$average_rating)), parse = TRUE, color = "orchid", size = 7)

# Do frequent raters rate differently?

tmp <- ratings %>% 
  group_by(user_id) %>% 
  summarize(mean_rating = mean(rating), number_of_rated_books = n())

tmp %>% filter(number_of_rated_books <= 100) %>% 
  ggplot(aes(number_of_rated_books, mean_rating)) + stat_bin_hex(bins = 50) + scale_fill_distiller(palette = "Spectral") + stat_smooth(method = "lm", color = "orchid", size = 2, se = FALSE) +
  annotate("text", x = 80, y = 1.9, label = get_cor(data.frame(x = tmp$number_of_rated_books, y = tmp$mean_rating)), color = "orchid", size = 7, parse = TRUE)

# Series of books

books %>% 
  filter(str_detect(str_to_lower(title), '\\(the lord of the rings')) %>% 
  select(book_id, title, average_rating) %>% 
  datatable(class="nowrap hover row-border", options = list(dom = 't',scrollX = TRUE, autoWidth = TRUE))


books <- books %>% 
  mutate(series = str_extract(title, "\\(.*\\)"), 
         series_number = as.numeric(str_sub(str_extract(series, ', #[0-9]+\\)$'),4,-2)),
         series_name = str_sub(str_extract(series, '\\(.*,'),2,-2))

tmp <- books %>% 
  filter(!is.na(series_name) & !is.na(series_number)) %>% 
  group_by(series_name) %>% 
  summarise(number_of_volumes_in_series = n(), mean_rating = mean(average_rating))


tmp %>% 
  ggplot(aes(number_of_volumes_in_series, mean_rating)) + stat_bin_hex(bins = 50) + scale_fill_distiller(palette = "Spectral") +
  stat_smooth(method = "lm", se = FALSE, size = 2, color = "orchid") +
  annotate("text", x = 35, y = 3.95, label = get_cor(data.frame(x = tmp$mean_rating,  y = tmp$number_of_volumes_in_series)), color = "orchid", size = 7, parse = TRUE)

# Is the sequel better than the original?

books %>% 
  filter(!is.na(series_name) & !is.na(series_number) & series_number %in% c(1,2)) %>% 
  group_by(series_name, series_number) %>% 
  summarise(m = mean(average_rating)) %>% 
  ungroup() %>% 
  group_by(series_name) %>% 
  mutate(n = n()) %>% 
  filter(n == 2) %>% 
  ggplot(aes(factor(series_number), m, color = factor(series_number))) +
  geom_boxplot() + coord_cartesian(ylim = c(3,5)) + guides(color = FALSE) + labs(x = "Volume of series", y = "Average rating")

# How long should a title be?

books <- books %>% 
  mutate(title_cleaned = str_trim(str_extract(title, '([0-9a-zA-Z]| |\'|,|\\.|\\*)*')),
         title_length = str_count(title_cleaned, " ") + 1) 

tmp <- books %>% 
  group_by(title_length) %>% 
  summarize(n = n()) %>% 
  mutate(ind = rank(title_length))

books %>% 
  ggplot(aes(factor(title_length), average_rating, color=factor(title_length), group=title_length)) +
  geom_boxplot() + guides(color = FALSE) + labs(x = "Title length") + coord_cartesian(ylim = c(2.2,4.7)) + geom_text(aes(x = ind,y = 2.25,label = n), data = tmp)

# Does having a subtitle improve the book's rating?

books <- books %>% 
  mutate(subtitle = str_detect(books$title, ':') * 1, subtitle = factor(subtitle))

books %>% 
  ggplot(aes(subtitle, average_rating, group = subtitle, color = subtitle)) + 
  geom_boxplot() + guides(color = FALSE)

# Does the number of authors matter?

books <- books %>% 
  group_by(book_id) %>% 
  mutate(number_of_authors = length(str_split(authors, ",")[[1]]))

books %>% filter(number_of_authors <= 10) %>% 
  ggplot(aes(number_of_authors, average_rating)) + stat_bin_hex(bins = 50) + scale_fill_distiller(palette = "Spectral") +
  stat_smooth(method = "lm", size = 2, color = "orchid", se = FALSE) + 
  annotate("text", x = 8.5, y = 2.75, label = get_cor(data.frame(x = books$number_of_authors, y = books$average_rating)), color = "orchid", size = 7, parse = TRUE)


# Collaborative Filtering

# Restructure the Data
dimension_names <- list(user_id = sort(unique(ratings$user_id)), book_id = sort(unique(ratings$book_id)))
ratingmat <- spread(select(ratings, book_id, user_id, rating), book_id, rating) %>% select(-user_id)


ratingmat <- as.matrix(ratingmat)
dimnames(ratingmat) <- dimension_names
ratingmat[1:5, 1:5]

dim(ratingmat)


# Using recommenderlab
# Replacing NA with 0

ratingmat0 <- ratingmat
ratingmat0[is.na(ratingmat0)] <- 0
ratingmat0[1:5, 1:5]
sparse_ratings <- as(ratingmat0, "sparseMatrix")
rm(ratingmat0)


real_ratings <- new("realRatingMatrix", data = sparse_ratings)
real_ratings

# Creating the model 

model <- Recommender(real_ratings, method = "UBCF", param = list(method = "pearson", nn = 4))

#Making predictions
# Define current user
prediction <- predict(model, real_ratings[current_user, ], type = "ratings")

# Evaluating the predictions

# The given parameter determines how many ratings are given to create the 
# predictions and in turn on how many predictions per user remain for the 
# evaluation of the prediction. In this case -1 means that the 
# predictions are calculated from all but 1 ratings, 
# and performance is evaluated for 1 for each user.

scheme <- evaluationScheme(real_ratings[1:500,], method = "cross-validation", k = 10, given = -1, goodRating = 5)

# In a second step, we can list all the algorithms we want to compare. 
# As we have a tuneable parameter nn, which is the number of most similar users
# which are used to calculate the predictions. Lets vary this parameter from 
# 5 to 50 and plot the RMSE. Furthermore, as a baseline one can also add 
# an algorithm ("RANDOM") that randomly predicts a rating for each user

algorithms <- list("random" = list(name = "RANDOM", param = NULL),
                   "UBCF_05" = list(name = "UBCF", param = list(nn = 5)),
                   "UBCF_10" = list(name = "UBCF", param = list(nn = 10)),
                   "UBCF_30" = list(name = "UBCF", param = list(nn = 30)),                   
                   "UBCF_50" = list(name = "UBCF", param = list(nn = 50))
)

# evaluate the alogrithms with the given scheme

results <- evaluate(scheme, method = algorithms, type = "ratings")


# restructure results output

tmp <- lapply(results, function(x) slot(x, "results"))
res <- tmp %>% 
  lapply(function(x) unlist(lapply(x, function(x) unlist(x@cm[ ,"RMSE"])))) %>% 
  as.data.frame() %>% 
  gather(key = "Algorithm", value = "RMSE")

res %>% 
  ggplot(aes(Algorithm, RMSE, fill = Algorithm)) +
  geom_bar(stat = "summary") + geom_errorbar(stat = "summary", width = 0.3, size = 0.8) +
  coord_cartesian(ylim = c(0.6, 1.3)) + guides(fill = FALSE)

# Different algorithms

# The following algorithms are available
recommenderRegistry$get_entry_names()

# You can get more information about these algorithms
recommenderRegistry$get_entries(dataType = "realRatingMatrix")



scheme <- evaluationScheme(real_ratings[1:500,], method = "cross-validation", k = 10, given = -1, goodRating = 5)

algorithms <- list("random" = list(name = "RANDOM", param = NULL),
                   "popular" = list(name = "POPULAR"),
                   "UBCF" = list(name = "UBCF"),
                   "SVD" = list(name = "SVD")
)

results <- evaluate(scheme, algorithms, type = "ratings", progress = FALSE)



# restructure results output
tmp <- lapply(results, function(x) slot(x, "results"))
res <- tmp %>% 
  lapply(function(x) unlist(lapply(x, function(x) unlist(x@cm[ ,"RMSE"])))) %>% 
  as.data.frame() %>% 
  gather(key = "Algorithm", value = "RMSE")

res %>% 
  mutate(Algorithm=factor(Algorithm, levels = c("random", "popular", "UBCF", "SVD"))) %>%
  ggplot(aes(Algorithm, RMSE, fill = Algorithm)) + geom_bar(stat = "summary") + 
  geom_errorbar(stat = "summary", width = 0.3, size = 0.8) + coord_cartesian(ylim = c(0.6, 1.3)) + 
  guides(fill = FALSE)
