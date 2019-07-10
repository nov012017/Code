
1) Folder Structure
	/home/cloudera/training/hadoop_examples/
   All examples are under this folder.
2) Ant is the buid tool we are using to compile the Hadoop programs, please read about ant,
   for all example, there is a build.xml fie in the corresponding folder, using that you can
   build by just invoking ant in the terminal.
   Ant would build the Jar file 
3) Java, Hadoop, Spark, SBT, Scala, Ant is already installed in the machine, so no need to install
   anything.
4) Each example is self contained, that is if you go to the folder you can compile and execute them
   without having any depency with other things.
5) Input for each programs needs to be in HDFS so there is instruction for copying the input data to 
   HDFS.
6) Output would be written to the HDFS file system, you have to look into HDFS file system to see the output
   Instruction to see them is given in the readme.txt file.

Work Hours Calculation Example:

In this example we are going to calculate the amount of time a user have spent on an activity, this is a simplified example of typical metering applications, say a user spend lots of time on different aspects of a website like facebook, and facebook wants to find where user spend moretime and where they dont spend time and have to properly allocate marketing budgets to address those areas where user activity is less or close feature where users don't show interest.

Typically a log of all users and all there activity would be available in their backend, here we see a simple example in which we don't tell what activity the user was engaged, but just put that they have started and stopeed the actitiy and we have the time when they started and when they stopped in the following manner


User Event Time
mmaniga,START,10
Ram,START,12
mmaniga,STOP,12
Dell,START,12
Dell,STOP,14
Ram,STOP,13


User Event Time
mmaniga,START,10
Ram,START,12
mmaniga,STOP,12
Dell,START,12
Dell,STOP,14
Ram,STOP,13

The task is to write a map reduce program to compute the total time spend by the user. In a real life scenario it woud be the total time user spend across many activiy. The output would be like this.

Dell	2
Ram	1
mmaniga	2

The concept here is how compute the time diffrent between two activity of the user. What has to be done in Map and What has to be done in reduce.

We know its a stateless architecture, so in map we can't know which user we are dealing with and which activiy we are dealing with, so we will have to deal with only the user and the time. (as programming activity you should think of adding activity , start , time.... activity, stop, time and get time spend on each activity).

So in Map we have to emit a pair saying user, time since its only one activity we don't have to bother about telling if its start or stop.

The logic in Map.

public void map(Object key,
                          Text value,
                          Context context) throws IOException, InterruptedException {
                            String[] lineinput = value.toString().split(",");
                            names.set(lineinput[0]);
                            time.set(Long.parseLong(lineinput[2]));
                            context.write(names, time);
                          }
                        }


In Reduce the logic is simple, we would have got the two time for the user and have to get the difference between the time and associate with the user and emit


        long start = 0;
          long stop = 0;
          public void reduce(Text key,
                             Iterable<LongWritable> values,
                             Context context) throws IOException,InterruptedException {
                                int sflag = 0;
                                for (LongWritable val : values) {
                                        if (sflag == 0) {
                                                start = val.get();
                                                sflag = 1;
                                        } else {
                                                stop = val.get();
                                        }
                                }
                                long time = Math.abs(stop - start);
                                context.write(key, new LongWritable(time));
        }


To Compile go the folder

cd /home/cloudera/training/hadoop_examples/timediff

in the terminal prompt type 

ant

To Execute
1) Copy input text file into HDFS 

	hadoop fs -put inputTime.txt input

2) Run

	hadoop jar TimeDifferenc.jar input/inputTime.txt outputTime

3) See Results

	Using HDFS File Navigator see the results.

4 Note
	When you run second time, you might get error file already present for both
	input and output, you have to delte those file using hdfs fs rm command



