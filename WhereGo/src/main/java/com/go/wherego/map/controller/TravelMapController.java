package com.go.wherego.map.controller;

import com.go.wherego.map.model.service.TravelMapService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class TravelMapController {

    @Autowired
    private TravelMapService travelMapService;

    @RequestMapping(value = "/travelMap")
    public String travelMap(@RequestParam(value = "mapX", required = false) String mapX,
                            @RequestParam(value = "mapY", required = false) String mapY,
                            @RequestParam(value = "keyword", required = false) String keyword,
                            Model model) {
        double mapXDouble = 126.981611; // Default longitude
        double mapYDouble = 37.568477;  // Default latitude

        if (mapX != null && mapY != null) {
            try {
                mapXDouble = Double.parseDouble(mapX);
                mapYDouble = Double.parseDouble(mapY);
            } catch (NumberFormatException e) {
                return "error";  // 오류 처리 페이지로 리다이렉트
            }
        }

        String touristData;
        if (keyword != null && !keyword.isEmpty()) {
            touristData = travelMapService.getTouristDataByKeyword(keyword);
        } else {
            touristData = travelMapService.getNearbyTouristData(mapXDouble, mapYDouble);
        }

        model.addAttribute("touristData", touristData);
        model.addAttribute("mapX", mapXDouble);
        model.addAttribute("mapY", mapYDouble);

        return "map/travelMap";  // 네이버 지도 페이지로 이동
    }

    @RequestMapping(value = "/")
    public String home() {
        return "home";  // 홈 페이지로 이동
    }
}
