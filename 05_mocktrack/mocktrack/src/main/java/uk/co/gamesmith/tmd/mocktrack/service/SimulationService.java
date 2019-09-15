package uk.co.gamesmith.tmd.mocktrack.service;

import com.amazonaws.services.sqs.AmazonSQS;
import com.amazonaws.services.sqs.AmazonSQSClientBuilder;
import com.amazonaws.services.sqs.model.SendMessageRequest;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
public class SimulationService {
    private final AmazonSQS sqs = AmazonSQSClientBuilder.defaultClient();

    @Value("${sqs.url}")
    private String sqsURL;

    public void simulate(String device_id) {
        final double longitude = -47.24395751953124;
        final double latitude = -23.1324672383945;
        final double step = 0.0005;

        simulateSingle(device_id, new Date(), longitude, latitude);  // test a single one for errors

        new Thread(() -> {
            double lon = longitude, lat = latitude;
            for (int i = 0; i < 5000; ++i) {
                lon += step;
                lat += step;
                simulateSingle(device_id, new Date(), lon, lat);
                try {
                    Thread.sleep(50);
                } catch (InterruptedException ignored) {}
            }
            System.out.println("Sending messages completed.");
        }).start();
    }

    private void simulateSingle(String device_id, Date date, double longitude, double latitude) {
        sqs.sendMessage(new SendMessageRequest(sqsURL, "{" +
                "\"deviceId\": \"" + device_id + "\"," +
                "\"eventTime\": \"" + date.getTime() + "\"," +
                "\"longitude\": " + longitude + "," +
                "\"latitude\": " + latitude + " }"));
    }
}
