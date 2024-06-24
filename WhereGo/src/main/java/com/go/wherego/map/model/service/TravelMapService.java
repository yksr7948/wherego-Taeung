package com.go.wherego.map.model.service;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URLEncoder;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class TravelMapService {
    private static final String DECODED_API_KEY = "57vRYb2zrToXS95vFiYv3jzLv2UOtdk3wOoeZsyxynkFe0kKsAzM8EN2mQihHRwf3WE8oPqkqqxYeP3THfJFaQ==";
    private static final String BASE_API_URL = "http://apis.data.go.kr/B551011/KorService1";

    public String getNearbyTouristData(double mapX, double mapY) {
        StringBuilder result = new StringBuilder();
        try {
            String encodedServiceKey = URLEncoder.encode(DECODED_API_KEY, StandardCharsets.UTF_8.toString());
            String urlStr = BASE_API_URL + "/locationBasedList1?serviceKey=" + encodedServiceKey 
                    + "&numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=AppTest&arrange=A&contentTypeId=12"
                    + "&mapX=" + String.format("%.6f", mapX) + "&mapY=" + String.format("%.6f", mapY) + "&radius=1000&_type=json";

            URL url = new URL(urlStr);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            BufferedReader rd;
            if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
                rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            } else {
                rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
            }

            String line;
            while ((line = rd.readLine()) != null) {
                result.append(line);
            }
            rd.close();
            conn.disconnect();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result.toString();
    }

    public String getTouristDataByKeyword(String keyword) {
        StringBuilder result = new StringBuilder();
        try {
            String encodedServiceKey = URLEncoder.encode(DECODED_API_KEY, StandardCharsets.UTF_8.toString());
            String encodedKeyword = URLEncoder.encode(keyword, StandardCharsets.UTF_8.toString());
            String urlStr = BASE_API_URL + "/searchKeyword1?serviceKey=" + encodedServiceKey 
                    + "&numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=AppTest&arrange=A&contentTypeId=12"
                    + "&keyword=" + encodedKeyword + "&_type=json";

            URL url = new URL(urlStr);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            BufferedReader rd;
            if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
                rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            } else {
                rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
            }

            String line;
            while ((line = rd.readLine()) != null) {
                result.append(line);
            }
            rd.close();
            conn.disconnect();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result.toString();
    }

    public List<String> getRelatedSearchTerms(String term) {
        List<String> relatedTerms = new ArrayList<>();
        try {
            String encodedServiceKey = URLEncoder.encode(DECODED_API_KEY, StandardCharsets.UTF_8.toString());
            String encodedTerm = URLEncoder.encode(term, StandardCharsets.UTF_8.toString());
            String urlStr = BASE_API_URL + "/searchKeyword1?serviceKey=" + encodedServiceKey 
                    + "&numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=AppTest&arrange=A&contentTypeId=12"
                    + "&keyword=" + encodedTerm + "&_type=json";

            URL url = new URL(urlStr);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            BufferedReader rd;
            if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
                rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            } else {
                rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
            }

            StringBuilder result = new StringBuilder();
            String line;
            while ((line = rd.readLine()) != null) {
                result.append(line);
            }
            rd.close();
            conn.disconnect();

            // Parse the JSON response to extract related search terms
            JsonObject json = JsonParser.parseString(result.toString()).getAsJsonObject();
            JsonObject response = json.getAsJsonObject("response");
            if (response != null) {
                JsonObject body = response.getAsJsonObject("body");
                if (body != null) {
                    JsonElement itemsElement = body.get("items");
                    if (itemsElement != null) {
                        if (itemsElement.isJsonArray()) {
                            JsonArray items = itemsElement.getAsJsonArray();
                            for (int i = 0; i < items.size(); i++) {
                                JsonObject item = items.get(i).getAsJsonObject();
                                String title = item.has("title") ? item.get("title").getAsString() : "";
                                relatedTerms.add(title);
                            }
                        } else if (itemsElement.isJsonObject()) {
                            JsonObject item = itemsElement.getAsJsonObject();
                            String title = item.has("title") ? item.get("title").getAsString() : "";
                            relatedTerms.add(title);
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return relatedTerms.stream()
                .filter(keyword -> keyword.contains(term))
                .collect(Collectors.toList());
    }
}
