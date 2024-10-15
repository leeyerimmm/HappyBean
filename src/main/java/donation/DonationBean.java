package donation;

import java.sql.Date;
import java.util.Vector;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class DonationBean {
	private int id;
    private String title;
    private String description;
    private int goalAmount;
    private int raisedAmount;
    private Date startDate; 
    private Date endDate;   
    private String category;
    private String thumb;
    private String company;
    private String subImages;       
    private String costDetails;    
    private String costDescriptions;
    private String costAmounts;      
    private String projectDuration; 
    private String targetGroup;     
    private int targetCount;       
    private String expectedEffect; 
    private String status;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getGoalAmount() {
        return goalAmount;
    }

    public void setGoalAmount(int goalAmount) {
        this.goalAmount = goalAmount;
    }

    public int getRaisedAmount() {
        return raisedAmount;
    }

    public void setRaisedAmount(int raisedAmount) {
        this.raisedAmount = raisedAmount;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getThumb() {
        return thumb;
    }

    public void setThumb(String thumb) {
        this.thumb = thumb;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getSubImages() {
        return subImages;
    }

    public void setSubImages(String subImages) {
        this.subImages = subImages;
    }

    public String getCostDetails() {
        return costDetails;
    }

    public void setCostDetails(String costDetails) {
        this.costDetails = costDetails;
    }

    public String getCostDescriptions() {
        return costDescriptions;
    }

    public void setCostDescriptions(String costDescriptions) {
        this.costDescriptions = costDescriptions;
    }

    public String getCostAmounts() {
        return costAmounts;
    }

    public void setCostAmounts(String costAmounts) {
        this.costAmounts = costAmounts;
    }

    public String getProjectDuration() {
        return projectDuration;
    }

    public void setProjectDuration(String projectDuration) {
        this.projectDuration = projectDuration;
    }

    public String getTargetGroup() {
        return targetGroup;
    }

    public void setTargetGroup(String targetGroup) {
        this.targetGroup = targetGroup;
    }

    public int getTargetCount() {
        return targetCount;
    }

    public void setTargetCount(int targetCount) {
        this.targetCount = targetCount;
    }

    public String getExpectedEffect() {
        return expectedEffect;
    }

    public void setExpectedEffect(String expectedEffect) {
        this.expectedEffect = expectedEffect;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    public Vector<String> getDescriptionParts() {
        if (description != null && !description.isEmpty()) {
            return new Vector<>(Arrays.asList(description.split("\\|")));
        } else {
            return new Vector<>();
        }
    }
    
    public List<String> getSubImagesList() {
        if (subImages != null && !subImages.isEmpty()) {
            return Arrays.asList(subImages.split("\\|"));
        }
        return new ArrayList<>();
    }
    
    public Vector<String> getCostDetailsList() {
        return new Vector<>(Arrays.asList(costDetails.split("\\|")));
    }

    public Vector<String> getCostDescriptionsList() {
        return new Vector<>(Arrays.asList(costDescriptions.split("\\|")));
    }

    public Vector<String> getCostAmountsList() {
        return new Vector<>(Arrays.asList(costAmounts.split("\\|")));
    }
}
