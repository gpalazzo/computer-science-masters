package SalesByCountry;

import java.io.IOException;
import java.util.*;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class SalesReducer extends Reducer <Text, Text, Text, IntWritable> {

  public void reduce(Text key, Iterable<Text> values, Context context) throws IOException, InterruptedException {

    int sum = 0;
    for (Text price: values) {
        try {
            sum += Integer.parseInt(price.toString());  
        } 
        catch (NumberFormatException e) { System.out.println(e); }
    }

    context.write(key, new IntWritable(sum));
  }
}