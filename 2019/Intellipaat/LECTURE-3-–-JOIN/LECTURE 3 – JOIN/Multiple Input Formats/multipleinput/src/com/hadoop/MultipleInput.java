package com.hadoop;

import java.io.IOException;
import java.util.StringTokenizer;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;
import org.apache.hadoop.mapreduce.lib.input.MultipleInputs;
import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class MultipleInput {


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
}

