package com.go.wherego.review.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.go.wherego.review.model.service.*;
import com.go.wherego.review.model.vo.Review;
import com.go.wherego.review.model.vo.ReviewPage;
import com.go.wherego.review.model.vo.ReviewReply;
import com.go.wherego.review.template.ReviewPagination;

@Controller
public class ReviewController {
	@Autowired
	private ReviewService rs;
	
	@RequestMapping("review.bo")
	public String reviewList(@RequestParam(value="currentPage",defaultValue="1")int currentPage,Model model) {
		int listCount = rs.listCount();
		int pageLimit = 10;
		int boardLimit = 5;
		System.out.println(1234);
		ReviewPage pi = ReviewPagination.getReviewPage(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Review> list = rs.selectList(pi);
		
		
		model.addAttribute("pi",pi);
		model.addAttribute("list",list);
		
		return "review/reviewList";
	}
	
	@RequestMapping("detail.bo")
	public ModelAndView selectReview(int boardNo,ModelAndView mv) {
		int result=rs.increaseCount(boardNo);
		if(result>0) {Review rv=rs.selectReview(boardNo);mv.addObject("rv",rv).setViewName("review/reviewDetail");}
		else {mv.addObject("errorMsg","조회에 실패").setViewName("common/errorPage");}
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="replyList.bo",produces="application/json;charset=UTF-8")
	public ArrayList<ReviewReply> replyList(int boardNo) {
		
		ArrayList<ReviewReply> rList = rs.replyList(boardNo);
		
		return rList;
	}
	
	@GetMapping("insert.bo")
	public String reviewEnroll() {
		
		return "review/reviewEnroll";
	}
	
	/*하는중*/
	@PostMapping("insert.bo")
	public String insertReview(Review rv,HttpSession session) {
		
		int result=rs.insertReview(rv);
		if(result>0) {
			session.setAttribute("alertMsg", "작성이 완료되었습니다!");
		}else {
			session.setAttribute("alertMsg", "오류가 발생해 작성되지 않았습니다...");
		}
		
		return "redirect:/review.bo";
	}
	
	
}
