package ca.jrvs.apps.practice;

public class Main {
    public static void main(String[] args) {
        RegexExc regex = new RegexExcImp();

        System.out.println(regex.matchJpeg("file.jpg"));     // true
        System.out.println(regex.matchIp("1.0.0.10"));        // true
        System.out.println(regex.isEmptyLine("   "));        // true
    }
}
