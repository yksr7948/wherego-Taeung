package com.go.wherego.entertain.controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Random;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.go.wherego.entertain.model.service.EntertainService;
import com.go.wherego.trip.model.vo.Trip;
import com.google.gson.Gson;



@Controller
public class EntertainController {
	
	@Autowired
	private EntertainService entertainService;
	
	@RequestMapping("worldcup.en")
	public String startWorldCup(Model model) {
		ArrayList<Trip>  list = entertainService.getTop100();
		System.out.println(list);
		model.addAttribute("list",new Gson().toJson(list));
		return "entertain/index";
	}

	// 가져온 Trip 랜덤으로 섞어서 입력한 개수만큼 뽑아오기 
//	public static ArrayList<Trip> makeRandom(ArrayList<Trip> list, int gang) {
//
//        Random random = new Random();
//        Set<Trip> selectedElements = new HashSet<>();
//        ArrayList<Trip> resultList = new ArrayList<>();
//
//        while (selectedElements.size() < gang) {
//            int randomIndex = random.nextInt(list.size());
//            Trip trip = list.get(randomIndex);
//            if (selectedElements.add(trip)) {
//                resultList.add(trip);
//            }
//        }
//        
//        return resultList;
//    }
	
	@PostMapping("worldcupresult.en")
	public String insertWcResult() {
		System.out.println("결승전 끝");
		return "main";	
	}
	
	
	
	
	
	
	
}
