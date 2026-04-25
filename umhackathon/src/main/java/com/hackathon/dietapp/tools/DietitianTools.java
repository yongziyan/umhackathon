package com.hackathon.dietapp.tools;

import com.hackathon.dietapp.model.Models.*;
import dev.langchain4j.agent.tool.Tool;
import org.springframework.stereotype.Component;
import java.util.List;

@Component
public class DietitianTools {

    @Tool("Get the user's profile, including their daily calorie goal, allergies, and preferred cuisine. Requires the userId.")
    public UserProfile getUserProfile(String userId) {
        System.out.println("GLM called Tool: Fetching profile for " + userId);
        return new UserProfile(userId, 2000, List.of("peanuts", "shellfish"), "Japanese");
    }

    @Tool("Calculate the nutritional value (calories, protein, carbs) for a specific food item the user ate today.")
    public NutritionalInfo getNutritionalValue(String foodItem) {
        System.out.println("GLM called Tool: Analyzing food item - " + foodItem);
        if (foodItem.toLowerCase().contains("ramen")) {
            return new NutritionalInfo(foodItem, 800, 20, 85);
        }
        return new NutritionalInfo(foodItem, 300, 15, 30); 
    }

    @Tool("Search for tomorrow's recipes based on a target calorie count, cuisine, and ingredients to strictly avoid.")
    public List<RecipeResult> searchRecipes(int targetCalories, String cuisine, List<String> avoidIngredients) {
        System.out.println("GLM called Tool: Searching recipes for " + targetCalories + " cals, " + cuisine + " cuisine.");
        return List.of(
            new RecipeResult("Teriyaki Tofu Bowl", "Grill tofu, add sauce, serve over rice.", 600, List.of("tofu", "rice", "teriyaki sauce")),
            new RecipeResult("Miso Soup with Veggies", "Boil broth, add miso paste and veggies.", 200, List.of("miso", "water", "spinach"))
        );
    }
}