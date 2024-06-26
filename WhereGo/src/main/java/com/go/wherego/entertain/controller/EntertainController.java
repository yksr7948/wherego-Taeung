package com.go.wherego.entertain.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.go.wherego.entertain.model.service.EntertainService;
import com.go.wherego.trip.model.vo.Trip;



@Controller
public class EntertainController {
	
	@Autowired
	private EntertainService entertainService;
	
	
	@RequestMapping("worldcup.en")
	public String startWorldCup() {
		ArrayList<Trip>  list = entertainService.getTop100();
		System.out.println(list);
		
		
		
		return "entertain/index";
	}
	
	
	
	
	
	
	
}
