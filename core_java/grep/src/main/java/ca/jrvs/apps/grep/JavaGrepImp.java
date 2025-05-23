package ca.jrvs.apps.grep;

import org.apache.log4j.BasicConfigurator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.regex.Pattern;

public class JavaGrepImp implements JavaGrep{

    private final Logger logger = LoggerFactory.getLogger(JavaGrepImp.class);

    private String regex;
    private String rootPath;
    private String outFile;

    public static void main(String[] args){
        if(args.length != 3) {
            throw new IllegalArgumentException("USAGE: JavaGrep regex rootpath outFile");
        }

        //Use default logger config
        BasicConfigurator.configure();

        JavaGrepImp javaGrepImp = new JavaGrepImp();
        javaGrepImp.setRegex(args[0]);
        javaGrepImp.setRootPath(args[1]);
        javaGrepImp.setOutFile(args[2]);

        try {
            javaGrepImp.process();
        } catch (Exception ex) {
            javaGrepImp.logger.error("Error: Unable to process", ex);
        }
    }
    @Override
    public void process() throws IOException {
        List<String> matchedLines = new ArrayList<>();
        Pattern pattern = Pattern.compile(getRegex());

        for (File file : listFiles(getRootPath())) {
            for (String line : readLines(file)) {
                if(containsPattern(line)) {
                    matchedLines.add(line);
                }
            }
        }

        writeToFile(matchedLines);
    }

    @Override
    public List<File> listFiles(String rootDir) {
        List<File> files = new ArrayList<>();
        File dir = new File(rootDir);

        if(!dir.isDirectory()) throw new IllegalArgumentException("Not a directory: " + rootDir);

        File[] fileList = dir.listFiles();
        if(fileList != null) {
            for(File f : fileList) {
                if(f.isDirectory()) {
                    files.addAll(listFiles(f.getAbsolutePath()));
                } else {
                    files.add(f);
                }
            }
        }

        return files;
    }

    @Override
    public List<String> readLines(File inputFile) throws IllegalArgumentException {
        return Collections.emptyList();
    }

    @Override
    public boolean containsPattern(String line) {
        return false;
    }

    @Override
    public void writeToFile(List<String> lines) throws IOException {

    }

    @Override
    public String getRootPath() {
        return rootPath;
    }

    @Override
    public void setRootPath(String rootPath) {
        this.rootPath = rootPath;
    }

    @Override
    public String getRegex() {
        return regex;
    }

    @Override
    public void setRegex(String regex) {
        this.regex = regex;
    }

    @Override
    public String getOutFile() {
        return outFile;
    }

    @Override
    public void setOutFile(String outFile) {
        this.outFile = outFile;
    }
}