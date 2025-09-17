package ca.jrvs.apps.practice;

import java.util.List;
import java.util.function.Consumer;
import java.util.stream.DoubleStream;
import java.util.stream.IntStream;
import java.util.stream.Stream;

public interface LambdaStreamExc {
    /**
     * Create a String stream from array
     *
     * @param strings
     * @return
     */
    Stream<String> createStrStream(String ... strings);

    /**
     * Convert all string to ippercase
     *
     * @param strings
     * @return
     */
    Stream<String> toUpperCase(String ... strings);

    /**
     * filter strings that contain the patters
     * e.g.
     * filter(stringStream, "a") will return another stream which no element contains a
     *
     * @param stringStream
     * @param pattern
     * @return
     */
    Stream<String> filter(Stream<String> stringStream, String pattern);

    /**
     * Create an intStream from a arr[]
     * @param arr
     * @return
     */
    IntStream createIntStream(int[] arr);

    /**
     * Convert a stream to a list
     *
     * @param stream
     * @param <E>
     * @return
     */
    <E> List<E> toList(Stream<E> stream);

    /**
     * Convert an intStream to list
     *
     * @param intStream
     * @return
     */
    List<Integer> toList(IntStream intStream);

    /**
     * Create an IntStream range from start to end inclusive
     * @param start
     * @param end
     * @return
     */
    IntStream createIntStream(int start, int end);

    /**
     * Convert an intStream to a doubleStream
     * and compute square root of each element
     * @param intStream
     * @return
     */
    DoubleStream squareRootIntStream(IntStream intStream);

    /**
     * filter all even numbers and return odd numbers from an intStream
     * @param intStream
     * @return
     */
    IntStream getOdd(IntStream intStream);

    /**
     * Return a lambda function that prints a message with a prefix and suffix
     *
     * e.g
     * LambdaStreamExc lse = new LambdaStreamImp();
     * Consumer<String> printer = lse.getLambdaPrinter("start>", "<end");
     * printer.accept("Message body");
     *
     * @param prefix str
     * @param suffix str
     * @return
     */
    Consumer<String> getLambdaPrinter(String prefix, String suffix);

    /**
     * Print each message with a given printer
     *
     * e.g.
     * String[] messages = {"a","b", "c"};
     * lse.printMessages(messages, lse.getLambdaPrinter("msg:", "!") );
     * sout:
     * msg:a!
     * msg:b!
     * msg:c!
     *
     * @param messages
     * @param printer
     */
    void printMessages(String[] messages, Consumer<String> printer);

    /**
     * Print all odd numbers from an intStream
     *
     * e.g.
     * lse.printOdd(lse.createIntStream(0, 5), lse.getLambdaPrinter("odd number:", "!"));
     * sout:
     * odd number:1!
     * odd number:3!
     * odd number:5!
     *
     * @param intStream
     * @param printer
     */
    void printOdd(IntStream intStream, Consumer<String> printer);

    /**
     * Square each number from the input
     *
     * @param ints
     * @return
     */
    Stream<Integer> flatNestedInt(Stream<List<Integer>> ints);
}