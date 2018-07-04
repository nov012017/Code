import pandas as pd
import matplotlib.pyplot as plt
import random

data= pd.read_csv("C:/Users/Admin/Desktop/Analytics Path/R/Data/Kaggle/house_pricing_kaggle.csv")
data[1]

n=4
ngrams={}
text="""Global warming or climate change has become a worldwide concern"""
for i in range(len(text)-n):
    gram=text[i:i+n]
    if gram not in ngrams.keys():
        #print(gram)
        ngrams[gram]=[]
        ngrams[gram].append(text[i+n])

## Testing our ngram model
currentGram=text[0:n]
result=currentGram
for i in range(100):
    if currentGram not in ngrams.keys():
        break
    possibilities=ngrams[currentGram]
   # possibilities=str(possibilities)
    nextItem=possibilities[random.randrange(len(possibilities))]
    result+=nextItem
    currentGram=result[len(result)-n:len(result)]
    #print(currentGram)
    
print(result)
result
    
    nextItem=possibilities[random.randrange(len(possibilities))]
    nextItem
    possibilities='Glo'
    possibilities[random.randrange(len(possibilities))]
    possibilities[3]
    