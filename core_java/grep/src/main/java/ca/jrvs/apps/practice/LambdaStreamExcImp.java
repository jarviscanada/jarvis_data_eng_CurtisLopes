package ca.jrvs.apps.practice;

import java.util.Collections;
import java.util.List;
import java.util.function.Consumer;
import java.util.stream.Collectors;
import java.util.stream.DoubleStream;
import java.util.stream.IntStream;
import java.util.stream.Stream;
import java.util.Arrays;

public class LambdaStreamExcImp implements LambdaStreamExc {

    @Override
    public Stream<String> createStrStream(String... strings) {
        return Stream.of(strings);
    }

    @Override
    public Stream<String> toUpperCase(String... strings) {
        return createStrStream(strings).map(String::toUpperCase);
    }

    @Override
    public Stream<String> filter(Stream<String> stringStream, String pattern) {
        return stringStream.filter(s -> !s.contains(pattern));
    }

    @Override
    public IntStream createIntStream(int[] arr) {
        return IntStream.of(arr);
    }

    @Override
    public <E> List<E> toList(Stream<E> stream) {
        return stream.collect(Collectors.toList());
    }

    @Override
    public List<Integer> toList(IntStream intStream) {
        return intStream.boxed().collect(Collectors.toList());
    }

    @Override
    public IntStream createIntStream(int start, int end) {
        return IntStream.rangeClosed(start, end);
    }

    @Override
    public DoubleStream squareRootIntStream(IntStream intStream) {
        return intStream.mapToDouble(Math::sqrt);
    }

    @Override
    public IntStream getOdd(IntStream intStream) {
        return intStream.filter(n -> n % 2 != 0);
    }

    @Override
    public Consumer<String> getLambdaPrinter(String prefix, String suffix) {
        return s -> System.out.println(prefix + s + suffix);
    }

    @Override
    public void printMessages(String[] messages, Consumer<String> printer) {
        for (String msg : messages) {
            printer.accept(msg);
        }
    }

    @Override
    public void printOdd(IntStream intStream, Consumer<String> printer) {
        getOdd(intStream).forEach(n -> printer.accept(String.valueOf(n)));
    }

    @Override
    public Stream<Integer> flatNestedInt(Stream<List<Integer>> ints) {
        return ints.flatMap(List::stream).map(i -> i * i);
    }

    // Main method to test implementations
    public static void main(String[] args) {
        LambdaStreamExcImp lambda = new LambdaStreamExcImp();

        // Test createStrStream and toUpperCase
        System.out.println("Uppercase:");
        lambda.toUpperCase("hello", "world").forEach(System.out::println);

        // Test filter
        System.out.println("\nFiltered (no 'a'):");
        lambda.filter(lambda.createStrStream("apple", "banana", "cherry", "mango"), "a")
                .forEach(System.out::println);

        // Test printMessages
        System.out.println("\nPrint messages:");
        lambda.printMessages(new String[]{"one", "two", "three"}, lambda.getLambdaPrinter(">>", "<<"));

        // Test printOdd
        System.out.println("\nPrint odd numbers:");
        lambda.printOdd(lambda.createIntStream(0, 5), lambda.getLambdaPrinter("Odd:", "!"));

        // Test flatNestedInt
        System.out.println("\nFlat map square:");
        Stream<List<Integer>> nested = Stream.of(Arrays.asList(1, 2), Arrays.asList(3, 4));
        lambda.flatNestedInt(nested).forEach(System.out::println);
    }

}