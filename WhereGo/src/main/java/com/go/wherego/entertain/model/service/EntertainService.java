package com.go.wherego.entertain.model.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.go.wherego.entertain.model.vo.WC;
import com.go.wherego.trip.model.vo.Trip;


public interface EntertainService {

	ArrayList<Trip> getTop100();

	void insertWCResult(WC wc);

	ArrayList<WC> getWcRanking();

	int getEntireGame();

	int getWinTime(String title);

	ArrayList<HashMap<String, BigDecimal>> getWcMbti(String title);

	int getMbtiCount(String title);

	ArrayList<HashMap<String, BigDecimal>> getWcAge(String title);

	ArrayList<HashMap<String, BigDecimal>> getWcGender(String title);

//	HashMap<String, Integer> getMbti(String title);

	

}
