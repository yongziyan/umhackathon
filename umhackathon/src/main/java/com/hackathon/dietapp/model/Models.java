package com.hackathon.dietapp.model;

import java.util.List;

public class Models {
    public record UserProfile(String userId, int dailyCalorieGoal, List<String> allergies, String preferredCuisine) {}
    public record NutritionalInfo(String foodItem, int calories, int proteinGrams, int carbsGrams) {}
    public record RecipeResult(String title, String instructions, int calories, List<String> ingredients) {}
}