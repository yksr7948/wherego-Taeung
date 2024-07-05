package com.go.wherego.entertain.controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Random;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.go.wherego.entertain.model.service.EntertainService;
import com.go.wherego.entertain.model.vo.WC;
import com.go.wherego.member.model.service.MemberService;
import com.go.wherego.member.model.vo.Member;
import com.go.wherego.trip.model.vo.Trip;
import com.google.gson.Gson;

@Controller
public class EntertainController {

	@Autowired
	private EntertainService entertainService;

	@Autowired
	private MemberService memberService;

	@RequestMapping("worldcup.en")
	public String startWorldCup(Model model, HttpSession session) {
		ArrayList<Trip> list = entertainService.getTop100();
		// System.out.println("처 음"+list);
		model.addAttribute("list", new Gson().toJson(list));
		return "entertain/worldcup";
	}

	@RequestMapping("rullet.en")
	public String startRullet(Model model) {
		ArrayList<Trip> list = entertainService.getTop100();
		ArrayList<Trip> ranList=makeRandom(list);
		model.addAttribute("list", new Gson().toJson(ranList));
		System.out.println(ranList);
		return "entertain/realRullet";
	}

	/*
	 * @RequestMapping("passGang") public String selectGang(Model model, String
	 * gang) { ArrayList<Trip> list = entertainService.getTop100();
	 * System.out.println("처 음"+list); model.addAttribute("list",new
	 * Gson().toJson(list)); }
	 */

	 //가져온 Trip 랜덤으로 섞어서 16개 가져오기
	public static ArrayList<Trip> makeRandom(ArrayList<Trip> list) {

        Random random = new Random();
        Set<Trip> selectedElements = new HashSet<>();
        ArrayList<Trip> resultList = new ArrayList<>();

        while (selectedElements.size() < 12) {
            int randomIndex = random.nextInt(list.size());
            Trip trip = list.get(randomIndex);
            if (selectedElements.add(trip)) {
                resultList.add(trip);
            }
        }
        
        return resultList;
    }

	@PostMapping("wcResult.en")
	public String insertWcResult(String userId, String winnerName, String check, Model model) {
		int flag = Integer.parseInt(check);
		/*
		 * if(userId==null) { if(flag==0) { return "entertain/index"; }else { return
		 * "entertain/ranking" ; } }
		 */
		Member m = memberService.getMemberById(userId);
		System.out.println(m.getTagWords());
		WC wc = new WC();
		wc.setUserId(userId);
		wc.setAge(m.getAge());
		wc.setTitle(winnerName);
		wc.setMBTI(m.getMBTI());
		wc.setTagWords(m.getTagWords());
		wc.setGender(m.getGender());
		System.out.println(wc);
		entertainService.insertWCResult(wc);
		if (flag == 0) {
			System.out.println("결승전 끝, 우승자는 : " + winnerName + " check : " + check + " 다시하기");
			ArrayList<Trip> list = entertainService.getTop100();
			model.addAttribute("list", new Gson().toJson(list));
			return "entertain/worldcup";
		} else {
			System.out.println("결승전 끝, 우승자는 : " + winnerName + " check : " + check + " 랭킹보기");
			ArrayList<WC> list = entertainService.getWcRanking();
			int entireGame=entertainService.getEntireGame(); //전체 게임 횟수 가져옴
			ArrayList<Integer> win = new ArrayList<>(); // 각 여행지별 게임 이긴 횟수 저장할 list

	        for (WC l : list) {
	        	int winTime = entertainService.getWinTime(l.getTitle()); //각 title이 이긴 횟수 반복문으로 저장 
	            win.add(winTime);
	        }
	        model.addAttribute("entireGame",entireGame);
	        model.addAttribute("winList",win);
			//model.addAttribute("list", new Gson().toJson(list));
			model.addAttribute("list",list);
			System.out.println(list);
			return "entertain/ranking";
		}
	}

}
