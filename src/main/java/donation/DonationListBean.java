package donation;

import java.sql.Date;

public class DonationListBean {
	private int donation_num;
	private int campaign_num;
	private String user_id;
	private int amount;
	private Date donation_date;
	private String donation_type;
	public int getDonation_num() {
		return donation_num;
	}
	public void setDonation_num(int donation_num) {
		this.donation_num = donation_num;
	}
	public int getCampaign_num() {
		return campaign_num;
	}
	public void setCampaign_num(int campaign_num) {
		this.campaign_num = campaign_num;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public Date getDonation_date() {
		return donation_date;
	}
	public void setDonation_date(Date donation_date) {
		this.donation_date = donation_date;
	}
	public String getDonation_type() {
		return donation_type;
	}
	public void setDonation_type(String donation_type) {
		this.donation_type = donation_type;
	}
	
}
