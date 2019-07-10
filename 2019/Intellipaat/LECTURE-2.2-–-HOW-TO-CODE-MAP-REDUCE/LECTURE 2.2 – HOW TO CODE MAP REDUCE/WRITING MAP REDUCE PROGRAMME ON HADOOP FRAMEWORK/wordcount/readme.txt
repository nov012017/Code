
1) Folder Structure
	/home/cloudera/training/hadoop_examples/
   All examples are under this folder.
2) Ant is the buid tool we are using to compile the Hadoop programs, please
read about ant,
   for all example, there is a build.xml fie in the corresponding folder,
using that you can
   build by just invoking ant in the terminal.
   Ant would build the Jar file 
3) Java, Hadoop, Spark, SBT, Scala, Ant is already installed in the machine,
so no need to install
   anything.
4) Each example is self contained, that is if you go to the folder you can
compile and execute them
   without having any depency with other things.
5) Input for each programs needs to be in HDFS so there is instruction for
copying the input data to 
   HDFS.
6) Output would be written to the HDFS file system, you have to look into HDFS
file system to see the output
   Instruction to see them is given in the readme.txt file.

WordCount Example:

This is equvalent to Hello World example in regular programming world, the
objective of this example
is to illustrate the power of Hadoop to solve a complex problme of counting
the word frequency in a document or many documents.

The idea here is simple, we have see in the theory part, to count words in the
document. For each word we should have a counter established and everytime we
see a word we increment the counter.

This logic looks simple, if we have to work with really very big document,
then we would be very slow as single thread would look each word and update
the word and look into another word.

The process is like this (This is pseudo code)

final ConcurrentMap<String, AtomicLong> wordCouter = 
    new ConcurrentHashMap<String, AtomicLong>();

while( (word = filePointer.getNextWord ) != endOfFile ) {

..
	wordCouter.putIfAbsent(word, new AtomicLong(0));
	wordCouter.get(word).incrementAndGet();
..
  
}

What we do is hash a HashMap of string and AtomicInteger. Everytime we
enounter a word, we see if the word is already present, if not insert the word
and set counter to zero, and get the word and increment by one, if the word is
already present, we get the word and increment.

This looks simple, but it would be slow if you are dealing with lots of words,
if would be difficut to parallize because, multiple threas would want to have
access to the HashMap, though Java has concurrent hashmap and we use
AtomicInteger, there is lot of treading issues to do it parallel.

We an do it parallel across virtual machines, that is, this wordCounter is
local to a single JVM.

To solve this word count from distributed systems perspective we have to look
into a differt manner.

First we should get a stateless model of thiking process. 
Next we should have a way to do things in parallel.

Stateless way of thinking is, everytime we see a word, we only have that
state, we dont know if this word has been seen by others or how many times
before its seen. The only information we have it, we have seen it once.

So note that down. <Word, Occurance >, we would just create a pair called
<Stiring,Int> saying, this word I have seen it once.

This stateless makes the code run in parallel, all threads or process can
tell, each word as they occur as seen once.

All these paris are put into a single place, and once in a single place, we
can do the gropuing (via sorting) so we could aggreate them and get final
value.

This conceptual model is called Map Reduce. In map we do the logic of
converting the file into pairs of <word,count> the could would be one always. 

    public void map(Object key, 
		    Text value, 
                    Context context
                    ) 
		throws IOException, InterruptedException {
      
      	StringTokenizer itr = new StringTokenizer(value.toString());
      
	while (itr.hasMoreTokens()) {
        
  		word.set(itr.nextToken());
        	context.write(word, one);
      }


These <word,count> pair is groped by a framework called Hadoop.
Once gropped we woud have a List<<word,count>> pair, this list of pair can be
passed used to sumaarise, each list has all the pairs of same word only. That
is, if there are 100 unique words we would have 100 List, and each list might
have 1..n pairs that depends on how many times the word has appreared.
so if Orance is 32 times, it would be availabe like this

List<
  <orange,1>,
  <orange,1>,
  <orange,1>,
  <orange,1>,
  <orange,1>,
  <orange,1>,

   ....
  <orange,1>,
  <orange,1>,
>

<String, <List<Int>>
<Organge, <
          1,1,1,1,,,,.1>
32 pairs would be there, this group can be itreated and got a sum. This is
what is done in the reduce code.

   public void reduce(Text key, Iterable<IntWritable> values,
                       Context context
                       ) throws IOException, InterruptedException {
      int sum = 0;
      for (IntWritable val : values) {
        sum += val.get();
      }
      result.set(sum);
      context.write(key, result);
    }


To Compile go the folder

cd /home/cloudera/training/hadoop_examples/wordcount

in the terminal prompt type 

ant

To Execute
1) Copy input text file into HDFS 

	hadoop fs -put marry.txt input

2) Run

	hadoop jar WordCount.jar input/marry.txt output

3) See Results

	Using HDFS File Navigator see the results.

4 Note
	When you run second time, you might get error file already present for
both
	input and output, you have to delte those file using hdfs fs rm
command



