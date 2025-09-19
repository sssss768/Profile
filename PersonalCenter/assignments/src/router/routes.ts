const routes = [
	{
		path: "/",
		redirect: "/assignments",
	},
	{
		name: "assignments",
		path: "/assignments",
		component: () => import("@/views/assignment/Assignments.vue"),
		meta: { title: "平时作业" },
		children:[
			{
				path: "calculate",
				component: () => import("@/views/assignment/Calculate.vue")
			},
			{
				path: "form",
				component: () => import("@/views/assignment/Form.vue")
			},
			{
				path: "experience",
				component: () => import("@/views/assignment/Experience.vue")
			},
			{
				path: "area",
				component: () => import("@/views/assignment/Area.vue")
			},
			{
				path: "submit",
				component: () => import("@/views/assignment/Submit.vue")
			},
			{
				path: "info",
				component: () => import("@/views/assignment/Information.vue")
			},
		]

	},
	{
		path: "/userLogin",
		component: () => import("@/views/student/Login.vue")
	},
	{
		path: "/user",
		component: () => import("@/views/student/User.vue")
	}
];

export default routes;

// {
// 	path: "",
// 	component: () => import("")
// }