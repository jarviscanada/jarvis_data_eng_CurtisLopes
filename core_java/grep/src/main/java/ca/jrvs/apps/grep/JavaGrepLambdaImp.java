package ca.jrvs.apps.grep;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class JavaGrepLambdaImp extends JavaGrepImp {

    public static void main(String[] args) {

        if(args.length != 3) {
            throw new IllegalArgumentException("USAGE: JavaGrep regex rootpath outFile");
        }

        //JavaGrepLambda inherits all methods except for 2 overridden methods below
        JavaGrepLambdaImp javaGrepLambdaImp = new JavaGrepLambdaImp();
        javaGrepLambdaImp.setRegex(args[0]);
        javaGrepLambdaImp.setRootPath(args[1]);
        javaGrepLambdaImp.setOutFile(args[2]);

        try {
            javaGrepLambdaImp.process();
        } catch(Exception ex) {
            ex.printStackTrace();
        }
    }

    @Override
    public List<File> listFiles(String rootDir) {
        try (Stream<Path> pathStream = Files.walk(Paths.get(rootDir))) {
            return pathStream.filter(Files::isRegularFile).map(Path::toFile).collect(Collectors.toList());
        } catch (IOException e) {
            throw new IllegalArgumentException("Cannot list files in directory: " + rootDir, e);
        }
    }

    @Override
    public List<String> readLines(File inputFile) {
        try (Stream<String> lines = Files.lines(inputFile.toPath(), StandardCharsets.UTF_8)) {
            return lines.collect(Collectors.toList());
        } catch (IOException e) {
            throw new IllegalArgumentException("Unable to read file: " + inputFile, e);
        }
    }
}