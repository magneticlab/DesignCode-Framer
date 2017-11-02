# Setup

defaultSpring = "spring(280, 27, 5)"

textExample = "Three years ago, Apple completely revamped their design language for modern users. It is now much simpler, allowing designers to focus on animation and function rather than intricate visual details."

closeBtn.y = -40
playBtn.opacity = 0
playBtn.scale = .75

pageComp = new PageComponent
	parent: PageView
	y: 60
	height: PageView.height - 60
	width: PageView.width
	scrollVertical: false
	contentInset: 
		left: 10
		right: 10

pageComp.addPage(Page1)
pageComp.addPage(Page2)

playBtn.states.Show =
	opacity: 1
	scale: 1
	animationOptions:
		curve: defaultSpring

playBtn.states.Hide =
	opacity: 0
	scale: .5
	animationOptions:
		time: .2

closeBtn.states.Show = 
	y: 40
	animationOptions:
		curve: defaultSpring

closeBtn.states.Hide = 
	y: -50
	animationOptions:
		time: .2

origX = iOSGuide.x
origY = iOSGuide.y
origSize = iOSGuide.size
origPos = iOSGuide.screenFrame

iOSGuide.states.Open =
	size: Screen.size
	x: 0
	y: 0
	borderRadius: 0
	animationOptions:
		curve: defaultSpring

iOSGuide.states.Close =
	size: origSize
	parent: Page1
	x: 23
	y: 258
	borderRadius: 15
	animationOptions:
		curve: defaultSpring

iOSGuideImage.states.Expanded = 
	height: 400
	animationOptions:
		curve: defaultSpring

iOSGuideImage.states.Initial = 
	height: 250
	animationOptions:
		curve: defaultSpring

articleText = new TextLayer
	text: textExample
	parent: iOSGuide
	x: 25
	y: 430
	width: Screen.width - 50
	fontSize: 17
	fontFamily: "SF-Pro-Text-Regular, -apple-system"
	lineHeight: 1.75
	color: "#000"

headerText = new TextLayer
	text: "Core Philosophies"
	parent: iOSGuide
	x: 25
	y: articleText.maxY + 20
	width: Screen.width - 50
	fontSize: 17
	fontWeight: 900
	fontFamily: "SF-Pro-Text-Bold, -apple-system"
	lineHeight: 1.75
	color: "#000"

iOSGuide.onTap ->
	this.parent = Chapters
	this.screenFrame = origPos
	
	StatusLight.visible = true
	StatusDark.visible = false
	this.placeBehind(StatusLight)
	
	this.animate("Open")
	iOSGuideImage.animate("Expanded")

	closeBtn.animate("Show")
	closeBtn.placeBefore(iOSGuide)
	playBtn.animate("Show")
	playBtn.placeBefore(iOSGuide)

closeBtn.onTap ->
	iOSGuide.animate("Close")
	iOSGuideImage.animate("Initial")
	
	StatusLight.visible = false
	StatusDark.visible = true
	
	closeBtn.animate("Hide")
	playBtn.animate("Hide")
	
iOSGuide.onAnimationEnd ->
	if iOSGuide.states.current.name is "Close"
		this.parent = Page1
		this.x = origX
		this.y = origY