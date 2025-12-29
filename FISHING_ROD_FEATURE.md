# Fishing Rod Recommendation Feature

## Overview

The `FishingRodRecommendation` class provides a simple way to fetch fishing rod recommendations from an external API based on a maximum price budget. This class extends the `Callout` base class and demonstrates best practices for API integration in Salesforce.

## Features

- Get fishing rod recommendations under $100 (default budget)
- Support for custom price limits
- Error handling with structured error responses
- Fully tested with comprehensive test coverage

## Usage

### Basic Usage - Get Recommendations Under $100

```apex
FishingRodRecommendation recommendation = new FishingRodRecommendation();
String response = recommendation.getRecommendationsUnder100();
System.debug('Recommendations: ' + response);
```

### Custom Price Limit

```apex
FishingRodRecommendation recommendation = new FishingRodRecommendation();
// Get recommendations under $75
String response = recommendation.getRecommendations(75);
System.debug('Recommendations: ' + response);
```

## Setup Instructions

### 1. Configure Named Credential

Before using this class, you need to configure a Named Credential in your Salesforce org:

1. Navigate to **Setup** > **Named Credentials**
2. Create a new Named Credential with the following details:
   - **Label**: Fishing Rod API
   - **Name**: `FishingRodAPI`
   - **URL**: Your fishing rod product API endpoint (e.g., `https://api.example.com`)
   - Configure authentication as needed for your API

### 2. Deploy the Code

Deploy the following files to your Salesforce org:
- `FishingRodRecommendation.cls`
- `FishingRodRecommendation.cls-meta.xml`
- `FishingRodRecommendationTest.cls` (optional, for testing)
- `FishingRodRecommendationTest.cls-meta.xml` (optional, for testing)

### 3. Test the Integration

Run the test class to verify everything is working:

```bash
sfdx force:apex:test:run -n FishingRodRecommendationTest -r human
```

## API Response Format

The API should return a JSON response in the following format:

```json
{
  "success": true,
  "products": [
    {
      "name": "Shimano FX Spinning Rod",
      "price": 49.99,
      "rating": 4.5
    },
    {
      "name": "Ugly Stik GX2 Spinning Rod",
      "price": 39.99,
      "rating": 4.7
    }
  ]
}
```

## Error Handling

If the API call fails, the class returns a structured error response:

```json
{
  "success": false,
  "statusCode": 500,
  "status": "Internal Server Error",
  "message": "Failed to fetch fishing rod recommendations"
}
```

## Best Recommendations Under $100

Based on typical market research, here are some commonly recommended fishing rods under $100:

1. **Ugly Stik GX2** (~$40-60) - Known for durability and sensitivity
2. **Shimano FX** (~$50) - Great balance of quality and affordability
3. **Penn Battle II** (~$80-90) - Excellent for saltwater fishing
4. **Daiwa BG** (~$90-100) - High-quality with great drag system
5. **Pflueger President** (~$70-80) - Smooth performance for the price

These are general recommendations and actual availability may vary through your API integration.

## Testing

The `FishingRodRecommendationTest` class provides comprehensive test coverage including:

- Success scenarios with valid responses
- Custom price limit testing
- Null price handling
- Error response handling

## Additional Notes

- The default maximum price is set to $100
- Price validation accepts any non-negative integer (including 0 for free items)
- The class uses HTTP GET requests to fetch recommendations
- Response codes in the 200 range are considered successful
