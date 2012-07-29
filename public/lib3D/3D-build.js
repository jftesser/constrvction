var container, stats;
var savecontainer, saverenderer, savescene;
var holder;
var front, back;

var camera, scene, renderer;
var mouseX = 0, mouseY = 0;

var windowHalfX = window.innerWidth / 2;
var windowHalfY = window.innerHeight / 2;
var renderw = 400;
var renderh = 650;
var mousex = 0, mousey= 0, pmousex= 0, pmousey= 0, dx= 0, dy= 0;
var texture;
var canvastexture = false;
var drift = false;

function loadthis(model) {
	var loader = new THREE.OBJLoader();
	//var tex = THREE.ImageUtils.loadTexture(img);
	
	loader.load(model, function(object) {

		for(var i = 0, l = object.children.length; i < l; i++) {

			object.children[i].material.map = texture;
			object.children[i].material.alphaTest = 0.5;
			object.children[i].doubleSided = true;
		}

		object.position.y = 0;
		object.scale.set(6.5, 6.5, 6.5);

		holder.add(object);
	});
}

function loadModel(obj,path) {
	var loader = new THREE.OBJLoader();
	//var obj = new THREE.Object3D();
	//var tex = THREE.ImageUtils.loadTexture(img);
	
	loader.load(path, function(object) {

		for(var i = 0, l = object.children.length; i < l; i++) {

			object.children[i].material.map = texture;
			object.children[i].material.alphaTest = 0.5;
			//console.log(object.children[i].material);
			object.children[i].doubleSided = true;
		}

		object.position.y = 0;
		object.scale.set(6.5, 6.5, 6.5);

		obj.add(object);
		//console.log(object);
	});
	//return obj;
}



function loadCanvas(canvas){
	canvastexture = true;
	texture = new THREE.Texture(canvas);
	texture.needsUpdate = true;
	
	for(var i = 0, l = holder.children[0].children.length; i < l; i++) {

		holder.children[0].children[i].material.map = texture;
		holder.children[0].children[i].doubleSided = true;
	}
}

function loadModelCanvas(object, canvas){
	canvastexture = true;
	texture = new THREE.Texture(canvas);
	texture.needsUpdate = true;
	
	for(var i = 0, l = object.children[0].children.length; i < l; i++) {

		object.children[0].children[i].material.map = texture;
		object.children[0].children[i].doubleSided = true;
	}
}

function loadModelImg(obj, path, img){
	var loader = new THREE.OBJLoader();
	//var obj = new THREE.Object3D();
	var tex = THREE.ImageUtils.loadTexture(img);
	
	loader.load(path, function(object) {

		for(var i = 0, l = object.children.length; i < l; i++) {

			object.children[i].material.map = tex;
			object.children[i].material.alphaTest = 0.5;
			//console.log(object.children[i].material);
			object.children[i].doubleSided = true;
		}

		object.position.y = 0;
		object.scale.set(6.5, 6.5, 6.5);

		obj.add(object);
		//console.log(object);
	});
}

function refresh(model, img) {
	var d = document.getElementById('render-container');
	var c = document.getElementById('GL');
	$("#GL").css('z-index',10);
	d.removeChild(c);

	loadthis(model, img);
}

function getPositionLeft(This) {
	var el = This;
	var pL = 0;
	while(el) {
		pL += el.offsetLeft;
		el = el.offsetParent;
	}
	return pL
}

function getPositionTop(This) {
	var el = This;
	var pT = 0;
	while(el) {
		pT += el.offsetTop;
		el = el.offsetParent;
	}
	return pT
}

function animate() {

	requestAnimationFrame(animate);
	if (canvastexture== true){
		texture.needsUpdate = true;
	}
	render();
}

function render() {
	if ( drift == true) {
		xang = front.rotation.x*0.99;
		yang = front.rotation.y*0.99;

		front.rotation.x = xang;
		front.rotation.y = yang;
		
		back.rotation.x = xang;
		back.rotation.y = yang;
	}
	
	camera.lookAt(scene.position);

	renderer.render(scene, camera);
}

function init3DBuild(obj1, obj2, img){
	mouseIsOver = false;
	
	container = document.getElementById("render-container");
	savecontainer = document.getElementById("export-container");

	scene = new THREE.Scene();
	savescene = new THREE.Scene();

	camera = new THREE.PerspectiveCamera(45, renderw / renderh, 1, 2000);
	camera.position.z = 120;
	scene.add(camera);

	var ambient = new THREE.AmbientLight(0x0C0C0C);
	scene.add(ambient);

	var directionalLight = new THREE.DirectionalLight(0xD6D6D6);
	directionalLight.position.set(70, 70, 100);
	//.normalize();
	scene.add(directionalLight);

	var directionalLight2 = new THREE.DirectionalLight(0xD6D6D6);
	directionalLight2.position.set(-70, 70, 100);
	//.normalize();
	scene.add(directionalLight2);


	holder = new THREE.Object3D();
	front = new THREE.Object3D();
	back = new THREE.Object3D();
	loadModel(front,obj1);
	loadModel(back,obj2);
	
	//texture = THREE.ImageUtils.loadTexture(img);
	texture = new THREE.Texture(front_canvas);
	canvastexture=true;
	texture.needsUpdate = true;

	scene.add(front);
	scene.add(back);

	
	var windowsize=viewport();
	var ratio = renderw/renderh;
	if (windowsize.height> renderh){
		console.log(windowsize.height);
		var h = windowsize.height;
		if (h > 850) {
			renderh = 850;
		} else {
			renderh = windowsize.height;
		}
		
		renderw = renderh * ratio;
	}
	
	
	// RENDERER

	renderer = new THREE.WebGLRenderer( { antialias: true, preserveDrawingBuffer : true } );
	renderer.setSize(renderw, renderh);
	renderer.domElement.id = "GL";
	container.appendChild(renderer.domElement);
	$("#GL").css('z-index',10);
	
	// SAVING RENDERER
	/*
	saverenderer = new THREE.WebGLRenderer( { antialias: true, preserveDrawingBuffer : true } );
	saverenderer.setSize(renderw, renderh);
	saverenderer.domElement.id = "GLsave";
	savecontainer.appendChild(saverenderer.domElement);
	*/
	animate();
	//saverenderer.render(savescene, camera);

	dx = getPositionLeft(document.getElementById("render-container")) - 5;
	dy = getPositionTop(document.getElementById("render-container")) - 5;
	
	var yamt = 0, xamt = 0;
	container.onmousemove = function(event) {
		
		
		if (mousePressed){
			//console.log(mousePressed);
		pmousex = mousex;
		pmousey = mousey;

		mousex = event.pageX - dx;
		mousey = event.pageY - dy;
		ease = 0.9;
		//yang = ((mousex / (renderw * 1.0) - 0.5) * Math.PI * 2.0)*(1.0-ease)+front.rotation.y*ease;
		//xang = ((mousey / (renderh * 1.0) - 0.5) * Math.PI * 0.3)*(1.0-ease)+front.rotation.x*ease;
		if (mousex-pmousex>0){
			yamt = .1;
		} else {
			yamt = -.1;
		}
		
		if (mousey-pmousey>0){
			xamt = .02;
		} else {
			xamt = -.02;
		}
	
		if (Math.abs(mousey-pmousey) > Math.abs(mousex-pmousex)) {
			front.rotation.x += xamt;
			back.rotation.x += xamt;
		} else {
			front.rotation.y += yamt;
			back.rotation.y += yamt;
		}
		
		}
		
	}
	
	container.onmouseup = function() {
		var rot = ((front.rotation.y+Math.PI)/(Math.PI*2)) *360;
		$("#rotate-slider").slider('value', rot);
	}
	
	container.onmouseover = function(event) {
		mouseIsOver = true;
	}
	
	container.onmouseout = function(event) {
		mouseIsOver = false;
	}
}

function viewport() {
	var e = window
	, a = 'inner';
	if ( !( 'innerWidth' in window ) )
	{
	a = 'client';
	e = document.documentElement || document.body;
	}
	return { width : e[ a+'Width' ] , height : e[ a+'Height' ] }
}