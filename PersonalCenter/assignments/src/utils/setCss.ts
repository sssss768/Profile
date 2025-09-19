import setThreeCss from "./setThreeCss.ts";

export default function setCss(type: boolean) {
	if (type) {
		document.documentElement.style.setProperty(
			"--overall-background-color",
			"#fff"
		);
		document.documentElement.style.setProperty(
			"--solid-color",
			"rgba(60, 60, 67, .12)"
		);
		document.documentElement.style.setProperty(
			"--font-main-color",
			"rgb(78, 78, 82)"
		);
		document.documentElement.style.setProperty(
			"--hover-color",
			"rgb(64, 158, 255)"
		);
		document.documentElement.style.setProperty(
			"--scroll-block-color",
			"rgba(60, 60, 67, .3)"
		);
		document.documentElement.style.setProperty(
			"--color-box-shadow",
			"rgba(200, 201, 204, .6)"
		);
		document.documentElement.style.setProperty("--theme-now", "#fff");
	} else {
		document.documentElement.style.setProperty(
			"--overall-background-color",
			"#1e1e20"
		);
		document.documentElement.style.setProperty(
			"--solid-color",
			"rgba(240, 239, 239, .2)"
		);
		document.documentElement.style.setProperty("--font-main-color", "#fff");
		document.documentElement.style.setProperty("--hover-color", "#e6755f");
		document.documentElement.style.setProperty(
			"--scroll-block-color",
			"rgba(60, 60, 67, .8)"
		);
		document.documentElement.style.setProperty(
			"--color-box-shadow",
			"rgba(233, 233, 235, .3)"
		);
		document.documentElement.style.setProperty("--theme-now", "#000");
	}
	setThreeCss(type);
}
