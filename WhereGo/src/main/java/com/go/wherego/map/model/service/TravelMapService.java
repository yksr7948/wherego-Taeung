package com.go.wherego.map.model.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URLEncoder;
import java.net.URL;
import java.nio.charset.StandardCharsets;

import org.springframework.stereotype.Service;

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
}
