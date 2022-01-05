export const defaultRoute = {
	UnauthenticatedHome: '/',
	AuthenticatedHome: '/AuthHome',
	Login: '/Login',
	Register: '/Register',
	ForgotPass: '/ForgotPass',
	CourseDetail: '/CourseDetail/:id',
	CourseDetailR: '/CourseDetail',
	ErrServer: '/ErrServer',
	NotFound: '/NotFound',
	Empty: '/Empty',
	FinalAssessment: '/FinalAssessment',
	SubmitAssignment: '/CourseDetail/SubmitAssignment/:id',
	SubmitAssignmentR: '/CourseDetail/SubmitAssignment',
	HomeSystem: '/HomeSystem',
	ReportCourse: '/ReportCourse/:id',
	Attendance: '/CourseDetail/Attendance/:id',
	AttendanceR: '/CourseDetail/Attendance',
	AssessCourse: '/CourseDetail/AssessCourse/:id',
	AssessCourseR: '/CourseDetail/AssessCourse',
	ViewGrade: '/CourseDetail/ViewGrade/:id',
	ViewGradeR: '/CourseDetail/ViewGrade',
	AssessTeacher: '/AssessTeacher',
	CourseEnroll: '/CourseEnroll/:id',
	CourseEnrollR: '/CourseEnroll',
	ViewNotification: '/ViewNotification',
	StudentManaging: '/StudentManaging',
	ForumComment: '/CourseDetail/ForumComment/:id',
	ForumCommentR: '/CourseDetail/ForumComment',
	ReportDetail: '/CourseDetail/ReportDetail/:id',
	ReportDetailR: '/CourseDetail/ReportDetail',
	ScoreManaging: '/CourseDetail/ScoreManaging/:id',
	ScoreManagingR: '/CourseDetail/ScoreManaging',
	CourseForum: '/CourseDetail/CourseForum/:id',
	UserManaging: '/UserManaging',
	CourseManaging: '/CourseManaging',
	TeacherManaging: '/TeacherManaging',
	CourseAnnouncement: '/CourseAnnouncement',
	Profile: '/Profile',
	ManageTimetable: '/ManageTimetable/:id',
	ManageTimetableR: '/ManageTimetable',
	CourseManagement: '/CourseManagement',
	DataStatistic: '/DataStatistic',
	ReportManagement: '/CourseDetail/ReportManagement/:id',
	ReportManagementR: '/CourseDetail/ReportManagement'

};

export const defaultTypeFile: Record<string, string> = {
	Document: 'Document',
	Avatar: 'Avatar',
	IdCard: 'IdCard',
	Certification: 'Certification',
	Course: 'Course',
	Assignment: 'Assignment'
};
export interface IRoute {
	url: string;
	name: string;
}
