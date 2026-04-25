package com.hackathon.dietapp.controller;

import com.hackathon.dietapp.agent.DietitianAgent;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/workflow")
@CrossOrigin(origins = "*") 
public class WorkflowController {

    private final DietitianAgent dietitianAgent;

    public WorkflowController(DietitianAgent dietitianAgent) {
        this.dietitianAgent = dietitianAgent;
    }

    @PostMapping("/chat")
    public String handleDietaryInput(
            @RequestParam String userId, 
            @RequestBody String userInput) {
        return dietitianAgent.chat(userId, userInput);
    }
}
