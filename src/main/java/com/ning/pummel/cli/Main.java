package com.ning.pummel.cli;



import org.skife.cli.Cli;
import org.skife.cli.Help;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLSession;
import java.util.concurrent.Callable;

public class Main
{
    public static void main(String[] args) throws Exception
    {
        HttpsURLConnection.setDefaultHostnameVerifier(new HostnameVerifier() {
            @Override
            public boolean verify(String s, SSLSession sslSession) {
                return true;
            }
        });

        //noinspection unchecked
        Cli.buildCli("pummel", Callable.class)
           .withCommands(Benchmark.class, Analyze.class, Limit.class, Step.class, Help.class)
           .withDefaultCommand(Help.class)
           .build().parse(args).call();

    }
}
