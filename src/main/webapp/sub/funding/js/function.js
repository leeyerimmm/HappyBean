document.addEventListener('DOMContentLoaded', function () {
	const slidesContainer = document.querySelector('.slides-container')
	const slides = Array.from(slidesContainer.querySelectorAll('p'))
	const prevButton = document.querySelector('.slides-prev')
	const nextButton = document.querySelector('.slides-next')
	const paginationItems = Array.from(document.querySelectorAll('.slides-pagination li')) // 페이지네이션 추가
	const slideWidth = 1140 // 슬라이드 하나의 너비
	let currentIndex = 1 // 첫 번째 슬라이드가 보이도록 설정 (초기화)
	let slideInterval
	const slideDuration = 3000 // 각 슬라이드가 머무르는 시간
	const transitionDuration = 500 // 애니메이션 지속 시간

	// 첫 번째와 마지막 슬라이드 복제
	const firstSlide = slides[0].cloneNode(true)
	const lastSlide = slides[slides.length - 1].cloneNode(true)

	slidesContainer.appendChild(firstSlide)
	slidesContainer.insertBefore(lastSlide, slides[0])

	const totalSlides = slides.length
	slidesContainer.style.width = `${(totalSlides + 2) * slideWidth}px`

	// 페이지네이션 업데이트 함수
	function updatePagination(index) {
		paginationItems.forEach((item, i) => {
			if (i === index - 1) {
				item.classList.add('on')
			} else {
				item.classList.remove('on')
			}
		})
	}

	// 슬라이드를 움직이는 함수
	function moveToSlide(index, transition = true) {
		if (transition) {
			slidesContainer.style.transition = `transform ${transitionDuration}ms ease-in-out`
		} else {
			slidesContainer.style.transition = 'none'
		}
		slidesContainer.style.transform = `translateX(-${index * slideWidth}px)`
		currentIndex = index
		updatePagination(currentIndex) // 페이지네이션 업데이트
	}

	// 슬라이드를 다음으로 넘기는 함수 (무한 루프)
	function goToNextSlide() {
		if (currentIndex < totalSlides) {
			moveToSlide(currentIndex + 1)
		} else {
			moveToSlide(totalSlides + 1)
			setTimeout(() => {
				slidesContainer.style.transition = 'none'
				slidesContainer.style.transform = `translateX(-${slideWidth}px)`
				currentIndex = 1
				updatePagination(currentIndex) // 첫 번째 슬라이드로 돌아가면서 페이지네이션 업데이트
				setTimeout(() => {
					slidesContainer.style.transition = `transform ${transitionDuration}ms ease-in-out`
				}, 50)
			}, transitionDuration)
		}
	}

	// 슬라이드를 이전으로 넘기는 함수 (무한 루프)
	function goToPrevSlide() {
		if (currentIndex > 1) {
			moveToSlide(currentIndex - 1)
		} else {
			moveToSlide(0)
			setTimeout(() => {
				slidesContainer.style.transition = 'none'
				slidesContainer.style.transform = `translateX(-${totalSlides * slideWidth}px)`
				currentIndex = totalSlides
				updatePagination(currentIndex) // 마지막 슬라이드로 돌아가면서 페이지네이션 업데이트
				setTimeout(() => {
					slidesContainer.style.transition = `transform ${transitionDuration}ms ease-in-out`
				}, 50)
			}, transitionDuration)
		}
	}

	// 페이지네이션 클릭 이벤트 추가
	paginationItems.forEach((item, index) => {
		item.addEventListener('click', function (e) {
			e.preventDefault()
			clearInterval(slideInterval) // 자동 슬라이드 중지
			moveToSlide(index + 1) // 클릭한 페이지로 이동
			startAutoSlide() // 다시 자동 슬라이드 시작
		})
	})

	// 슬라이드 초기화 함수
	function initializeSlider() {
		slidesContainer.style.transition = 'none'
		slidesContainer.style.transform = `translateX(-${slideWidth}px)`
		currentIndex = 1
		updatePagination(currentIndex) // 초기화 시 페이지네이션도 설정
	}

	// 자동 슬라이드 이동 함수
	function startAutoSlide() {
		slideInterval = setInterval(() => {
			goToNextSlide()
		}, slideDuration)
	}

	// 이전 버튼 클릭 시
	prevButton.addEventListener('click', function (e) {
		e.preventDefault()
		clearInterval(slideInterval)
		goToPrevSlide()
		startAutoSlide()
	})

	// 다음 버튼 클릭 시
	nextButton.addEventListener('click', function (e) {
		e.preventDefault()
		clearInterval(slideInterval)
		goToNextSlide()
		startAutoSlide()
	})

	// 초기화 및 자동 슬라이드 시작
	initializeSlider()
	startAutoSlide()
})
