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

public class TimeDifference {

  public static class TokenizerMapper
        extends Mapper<Object, Text, Text, LongWritable>{
          private final static LongWritable time = new LongWritable();
          private Text names = new Text();

          public void map(Object key,
                          Text value,
                          Context context) throws IOException, InterruptedException {
                            String[] lineinput = value.toString().split(",");
                            names.set(lineinput[0]);
                            time.set(Long.parseLong(lineinput[2]));
                            context.write(names, time);
                          }
                        }
 
  public static class UserTimeReducer
        extends Reducer<Text, LongWritable, Text, LongWritable> {
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
}



  public static void main(String[] args) throws Exception {
    Configuration conf = new Configuration();
    String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
    if (otherArgs.length != 2) {
      System.err.println("Usage: TimeDifference <in> <out>");
      System.exit(2);
    }
    Job job = new Job(conf, "Time Difference");
    job.setJarByClass(TimeDifference.class);
    job.setMapperClass(TokenizerMapper.class);
    //job.setCombinerClass(UserTimeReducer.class);
    job.setReducerClass(UserTimeReducer.class);
    job.setOutputKeyClass(Text.class);
    job.setOutputValueClass(LongWritable.class);
    FileInputFormat.addInputPath(job, new Path(otherArgs[0]));
    FileOutputFormat.setOutputPath(job, new Path(otherArgs[1]));
    System.exit(job.waitForCompletion(true) ? 0 : 1);
  }
}

