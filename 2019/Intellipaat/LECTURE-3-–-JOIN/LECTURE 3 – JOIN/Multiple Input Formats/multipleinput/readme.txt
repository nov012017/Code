
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

Working with multiple input files

In this example we are going to deal with multiple input file, to simulate a simple join.

Input Files 

Customer :

Mobile,Name
123,mani
456,vijay
888,ravi

Delivery

Mobile,Staus
123,0
888,1
456,1


The task is to write a map reduce program to get a joined outout in the following manner

mani	0
vijay	1
ravi	1

The concept here is to identify key from multiple input file, pull relevant data and stich them together in reduce. This is typicaly how to handle join. 

We are to deal with multiple input file, to handle mulitple input, this is how the drive program has to be written

  public static void main(String[] args) throws Exception {
        Configuration conf = new Configuration();
        String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
        if (otherArgs.length != 3) {
            System.err.println("Usage: TimeDifference <in1> <in2> <out>");
            System.exit(2);
        }
        Job job = new Job(conf, "Multiple Input");
        job.setJarByClass(MultipleInput.class);

        MultipleInputs.addInputPath(job, new Path(args[0]),
                TextInputFormat.class, CustomerDetailsMapper.class);

        MultipleInputs.addInputPath(job, new Path(args[1]),
                TextInputFormat.class, DeliveryStatusMapper.class);

        FileOutputFormat.setOutputPath(job, new Path(otherArgs[2]));
        job.setReducerClass(CustDeliveryReducer.class);

        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(Text.class);

        System.exit(job.waitForCompletion(true) ? 0 : 1);
    }


We have to write two mapper class, one for Customer and one for delivery.

    public static class CustomerDetailsMapper
    extends Mapper < Object, Text, Text, Text > {
        private String cellNumber;
        private String customerName;
        private String tag = "Cust~";

        public void map(Object key,
                Text value,
                Context context) throws IOException,
            InterruptedException {
                String line = value.toString();
                String splitarray[] = line.split(",");
                cellNumber = splitarray[0].trim();
                customerName = splitarray[1].trim();
                context.write(
                    new Text(cellNumber),
                    new Text(tag + customerName));
            }
    }
  123,Cust~Mani


Delivery Mapper

    public static class DeliveryStatusMapper
    extends Mapper < Object, Text, Text, Text > {
        private String cellNumber;
        private String deliveryCode;
        private String tag = "Delivery~";

        public void map(Object key,
                Text value,
                Context context) throws IOException,
            InterruptedException {
                String line = value.toString();
                String splitarray[] = line.split(",");
                cellNumber = splitarray[0].trim();
                deliveryCode = splitarray[1].trim();
                context.write(
                    new Text(cellNumber),
                    new Text(tag + deliveryCode));
            }
    }


The reducer stiched everything

   public static class CustDeliveryReducer
    extends Reducer < Text, Text, Text, Text > {
        private String customerName;
        private String deliveryReport;

        public void reduce(Text key,
            Iterable < Text > values,
            Context context) throws IOException,InterruptedException {

            for(Text t : values) {
                String currValue = t.toString();
                String valueSplitted[] = currValue.split("~");

                if (valueSplitted[0].equals("Cust"))
                    customerName = valueSplitted[1].trim();
                else if (valueSplitted[0].equals("Delivery"))
                    deliveryReport = valueSplitted[1].trim();
            }
            context.write(new Text(customerName), new Text(deliveryReport));
        }
    }



To Compile go the folder

/home/cloudera/training/hadoop_examples/multipleinput

in the terminal prompt type 

ant

To Execute
1) Copy input text file into HDFS 

	hadoop fs -put customer.txt input
	hadoop fs -put delivery.txt input

2) Run

	hadoop jar MultipleInput.jar input/customer.txt input/delivery.txt outputDelivery

3) See Results

	Using HDFS File Navigator see the results.

4 Note
	When you run second time, you might get error file already present for both
	input and output, you have to delte those file using hdfs fs rm command



