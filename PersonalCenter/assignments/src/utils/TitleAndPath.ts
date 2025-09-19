/**
 * 锚点数组，每一个小页面的标题及其路径信息
 */
const titleAndPath = [
	{
		name: "主页",
		path: "#main",
	},
	{
		name: "信息",
		path: "#info",
	},
	{
		name: "美食",
		path: "#food",
	},
	{
		name: "景点",
		path: "#scenery",
	},
	{
		name: "文化",
		path: "#culture",
	},
	// {
	// 	name: "最后",
	// 	path: "#end",
	// },
];

export default titleAndPath;

export const partTitleAndPath = titleAndPath.filter((_, index) => index !== 0);
