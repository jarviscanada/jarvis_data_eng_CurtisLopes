package ca.jrvs.apps.practice;

import java.util.regex.Pattern;

public class RegexExcImp implements RegexExc {

    private static final Pattern JPEG_PATTERN = Pattern.compile("(?i)^.+\\.(jpg|jpeg)$");
    private static final Pattern IP_PATTERN = Pattern.compile("^\\d{1,3}(\\.\\d{1,3}){3}$");
    private static final Pattern EMPTY_LINE_PATTERN = Pattern.compile("^\\s*$");

    @Override
    public boolean matchJpeg(String filename){
        return filename != null && JPEG_PATTERN.matcher(filename).matches();
    }

    @Override
    public boolean matchIp(String ip){
        return ip != null && IP_PATTERN.matcher(ip).matches();
    }

    @Override
    public boolean isEmptyLine(String line){
        return line != null && EMPTY_LINE_PATTERN.matcher(line).matches();
    }
}