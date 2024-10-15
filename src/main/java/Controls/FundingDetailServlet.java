package Controls;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Detail")
public class FundingDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private FundingMgr fundingMgr;

    public void init() {
        fundingMgr = new FundingMgr(); // FundingMgr 초기화
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int num = Integer.parseInt(request.getParameter("num")); // num 파라미터 가져오기
        FundingBean funding = fundingMgr.getFundingById(num); // 펀딩 정보 조회

        request.setAttribute("funding", funding); // JSP로 전달할 데이터 설정
        RequestDispatcher dispatcher = request.getRequestDispatcher("detail.jsp");
        dispatcher.forward(request, response); // JSP로 포워드
    }
}
