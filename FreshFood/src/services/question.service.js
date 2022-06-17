const USER = require('../models/User.model');
const { defaultRoles } = require('../config/defineModel');
const otpGenerator = require('otp-generator');
const { configEnv } = require('../config/index');
const nodemailer = require('nodemailer');
const QUESTION = require('../models/Question.model');
const GROUPQUESTION = require('../models/GroupQuestion.model');
const ANSWER = require('../models/Answer.model')

exports.createQuestionAsync = async body => {
	try {
		const question = new QUESTION(body);
		await question.save();
		
		return {
			message: 'Successfully create Question',
			success: true,
			data: question
		};
	} catch (e) {
		console.log(e)
		return {
			message: 'An error occurred',
			success: false
		};
	}
};

exports.updateQuestionAsync = async (id, body) => {
	try {
		const question = await QUESTION.findOneAndUpdate(
			{ _id: id },
			body,
			{
				new: true
			}
		);

		return {
			message: 'Successfully update Question',
			success: true,
			data: question
		};
	} catch (e) {
		return {
			message: 'An error occurred',
			success: false
		};
	}
};

exports.deleteQuestionAsync = async id => {
	try {
		const question = await QUESTION.deleteOne({ _id: id });
		return {
			message: 'Successfully delete Question',
			success: true
		};
	} catch (e) {
		return {
			message: 'An error occurred',
			success: false
		};
	}
};

exports.getAllQuestionByGroupAsync = async (idCustomer) => {
	try {
		const groupQuestionActive = await GROUPQUESTION.findOne({isActive: true});
		if(groupQuestionActive === null)
		{
			return {
				message: 'Game is inactive',
				success: false,
				data: null
			};
		}

		const listQuestion = await QUESTION.find({groupQuestion: groupQuestionActive.id}).sort({ createdAt: -1 });
		if(listQuestion.length === 0)
		{
			return {
				message: 'There are currently no questions',
				success: false,
				data: null
			};
		}
		const newListQuestion = await Promise.all(listQuestion.map(async (question) =>  {
			const checkAnswer = await ANSWER.findOne({userId: idCustomer,questionId: question.id});
			if(checkAnswer !==  null)
			{
				return {
					isTrueA: question.isTrueA,
					isTrueB: question.isTrueB,
					isTrueC: question.isTrueC,
					isTrueD: question.isTrueD,
					time: question.time,
					_id: question.id,
					title: question.title,
					answerA: question.answerA,
					answerB: question.answerB,
					answerC: question.answerC,
					answerD: question.answerD,
					groupQuestion: question.groupQuestion,
					createdAt: question.createdAt,
					updatedAt: question.updatedAt,
					isAnswer: true
				}
			}
			return  {
				isTrueA: question.isTrueA,
				isTrueB: question.isTrueB,
				isTrueC: question.isTrueC,
				isTrueD: question.isTrueD,
				time: question.time,
				_id: question.id,
				title: question.title,
				answerA: question.answerA,
				answerB: question.answerB,
				answerC: question.answerC,
				answerD: question.answerD,
				groupQuestion: question.groupQuestion,
				createdAt: question.createdAt,
				updatedAt: question.updatedAt,
				isAnswer: false
			}
		}))

		return {
			message: 'Successfully get all Question by group question',
			success: true,
			data: newListQuestion
		};
	} catch (e) {
		return {
			message: 'An error occurred',
			success: false
		};
	}
};

exports.getAllQuestionByIdGroupAsync = async (groupQuestionId,customerId) => {
	try {
		const listQuestion = await QUESTION.find({groupQuestion: groupQuestionId}).sort({ createdAt: -1 });
		if(listQuestion.length === 0)
		{
			return {
				message: 'There are currently no questions',
				success: false,
				data: null
			};
		}

		return {
			message: 'Successfully get all Question by id group question',
			success: true,
			data: listQuestion
		};
	} catch (e) {
		console.log(e)
		return {
			message: 'An error occurred',
			success: false
		};
	}
};

exports.checkUserAnswerQuestion = async body => {
	try {
		const { customerId,groupQuestionId } = body;
		const listQuestion = await QUESTION.find({groupQuestion: groupQuestionId}).sort({ createdAt: -1 });
		if(listQuestion[0] == null || listQuestion[0] == undefined)
			return {
				message: 'Group Question does not question',
				success: false
			};

		var answer = await ANSWER.find({customerId: customerId,questionId: listQuestion[0].id});
		var checkAnswer = false;
		if(answer != null )
			checkAnswer = true;

		return {
			message: 'Successfully check user answer question',
			success: true,
			data: checkAnswer
		};
	} catch (e) {
		return {
			message: 'An error occurred',
			success: false
		};
	}
};