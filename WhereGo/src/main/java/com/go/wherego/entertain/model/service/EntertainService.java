package com.go.wherego.entertain.model.service;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import com.go.wherego.entertain.model.vo.WC;
import com.go.wherego.trip.model.vo.Trip;


public interface EntertainService {

	ArrayList<Trip> getTop100();

	void insertWCResult(WC wc);

}
