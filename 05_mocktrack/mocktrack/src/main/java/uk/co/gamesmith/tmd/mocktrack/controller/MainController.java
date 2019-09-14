package uk.co.gamesmith.tmd.mocktrack.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import uk.co.gamesmith.tmd.mocktrack.entity.HelloEntity;

@RestController
public class MainController {
    @GetMapping("/hello")
    public HelloEntity hello() {
        return new HelloEntity("world");
    }
}
