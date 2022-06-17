const USER = require('../models/User.model');
const { defaultRoles } = require('../config/defineModel');
const otpGenerator = require('otp-generator');
const { configEnv } = require('../config/index');
const nodemailer = require('nodemailer');
const ANSWER = require('../models/Answer.model');
const QUESTION = require('../models/Question.model');

exports.createAnswerAsync = async body => {
	try {
		questionCurrent = await QUESTION.findById(body.questionId);
		if (questionCurrent == null)
			return {
				message: 'Question does not exist',
				success: false
			};

		var resultQuestion = '';
		if (questionCurrent.isTrueA == true) resultQuestion = resultQuestion + 'A';
		if (questionCurrent.isTrueB == true) resultQuestion = resultQuestion + 'B';
		if (questionCurrent.isTrueC == true) resultQuestion = resultQuestion + 'C';
		if (questionCurrent.isTrueD == true) resultQuestion = resultQuestion + 'D';
		var userCurrent = await USER.findById(body.userId);

		if (resultQuestion.includes(body.result)) {
			console.log(userCurrent)
			var pointAdd = 100 ;
			var point = pointAdd + userCurrent.point;
			var userUpdate = await USER.findOneAndUpdate(
				{ _id: body.userId },
				{ point: point },
				{ new: true }
			);
			
			body.isTrue = true;
			body.point = pointAdd;
		} else {
			body.isTrue = false;
			var pointAdd = 50 ;
			console.log(userCurrent)

			var point = pointAdd + userCurrent.point;
			var userUpdate = await USER.findOneAndUpdate(
				{ _id: body.userId },
				{ point: point },
				{ new: true }
			);
			body.point = pointAdd;
		}
		
		const answer = new ANSWER(body);
		await answer.save();

		return {
			message: 'Successfully create Answer',
			success: true,
			data: answer
		};
	} catch (e) {
		console.log(e);
		return {
			message: 'An error occurred',
			success: false
		};
	}
};

exports.updateAnswerAsync = async (id, body) => {
	try {
		const answer = await ANSWER.findOneAndUpdate({ _id: id }, body, {
			new: true
		});

		return {
			message: 'Successfully update ANSWER',
			success: true,
			data: answer
		};
	} catch (e) {
		return {
			message: 'An error occurred',
			success: false
		};
	}
};

exports.deleteAnswerAsync = async id => {
	try {
		const answer = await ANSWER.deleteOne({ _id: id });
		return {
			message: 'Successfully delete ANSWER',
			success: true
		};
	} catch (e) {
		return {
			message: 'An error occurred',
			success: false
		};
	}
};

exports.getAnswerByIdQuestion = async (questionId, userId) => {
	try {
		const answer = await ANSWER.findOne({
			questionId: questionId,
			userId: userId
		});

		return {
			message: 'Successfully get answer',
			success: true,
			data: answer
		};
	} catch (e) {
		return {
			message: 'An error occurred',
			success: false
		};
	}
};
