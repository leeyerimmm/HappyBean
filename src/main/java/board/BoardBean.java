package board;

import java.sql.Timestamp;

public class BoardBean {

	private int id; // 게시글 ID
	private String title; // 게시글 제목
	private String content; // 게시글 내용
	private Timestamp createdAt; // 작성 일시

	// 기본 생성자
	public BoardBean() {
	}

	// ID (id) Getter/Setter
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
		System.out.println(id);
	}

	// 제목 (title) Getter/Setter
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	// 내용 (content) Getter/Setter
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	// 작성 일시 (createdAt) Getter/Setter
	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	// toString() 메서드 - 디버깅 및 로깅에 유용
	@Override
	public String toString() {
		return "BoardBean{" + "title='" + title + '\'' + ", content='" + content + '\'' + ", createdAt=" + createdAt
				+ '}';
	}

}
