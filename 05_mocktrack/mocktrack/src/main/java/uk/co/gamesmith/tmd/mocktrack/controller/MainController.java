package uk.co.gamesmith.tmd.mocktrack.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import uk.co.gamesmith.tmd.mocktrack.entity.HelloEntity;
import uk.co.gamesmith.tmd.mocktrack.service.SimulationService;

@RestController
public class MainController {
    private final SimulationService simulationService;

    @Autowired
    public MainController(SimulationService simulationService) {
        this.simulationService = simulationService;
    }

    @GetMapping("/")
    public ResponseEntity healthCheck() {
        return ResponseEntity.ok().build();
    }

    @GetMapping("/hello")
    public HelloEntity hello() {
        return new HelloEntity("world");
    }

    @PostMapping("/simulate/{device_id}")
    public ResponseEntity simulate(@PathVariable String device_id) {
        simulationService.simulate(device_id);
        return ResponseEntity.ok("Simulation messages generated");
    }
}
