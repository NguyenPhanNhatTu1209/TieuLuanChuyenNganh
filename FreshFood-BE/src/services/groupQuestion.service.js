const USER = require('../models/User.model');
const { defaultRoles } = require('../config/defineModel');
const otpGenerator = require('otp-generator');
const { configEnv } = require('../config/index');
const nodemailer = require('nodemailer');
const GROUPQUESTION = require('../models/GroupQuestion.model');
const QUESTION = require('../models/Question.model');

exports.createGroupQuestionAsync = async body => {
	try {
		if (body.isActive == true) {
			listGroupQuestion = await GROUPQUESTION.find();
			if (listGroupQuestion.length > 0) {
				for (let i = 0; i < listGroupQuestion.length; i++) {
					listGroupQuestion[i].isMain = false;
					listGroupQuestion[i].save();
				}
			}
		}
		const groupQuestion = new GROUPQUESTION(body);
		await groupQuestion.save();

		return {
			message: 'Successfully create Group',
			success: true,
			data: groupQuestion
		};
	} catch (e) {
		console.log(e);
		return {
			message: 'An error occurred',
			success: false
		};
	}
};

exports.updateGroupQuestionAsync = async (id, body) => {
	try {
		if(body.isActive === true)
		{
			await GROUPQUESTION.updateMany({_id: {$ne: id}},{isActive: false}, {new: true});
		}

		const groupQuestion = await GROUPQUESTION.findOneAndUpdate(
			{ _id: id },
			body,
			{
				new: true
			}
		);

		return {
			message: 'Successfully update Group',
			success: true,
			data: groupQuestion
		};
	} catch (e) {
		return {
			message: 'An error occurred',
			success: false
		};
	}
};

exports.deleteGroupQuestionAsync = async id => {
	try {
		const groupQuestion = await GROUPQUESTION.deleteOne({ _id: id });
		return {
			message: 'Successfully delete Group',
			success: true
		};
	} catch (e) {
		return {
			message: 'An error occurred',
			success: false
		};
	}
};

exports.getAllGroupQuestionAsync = async () => {
	try {
		var groupQuestion = await GROUPQUESTION.find().sort({ createdAt: -1 });
		var listResult = [];
		
		for (let i = 0; i < groupQuestion.length; i++) {
			var numberQuestion = await QUESTION.find({
				groupQuestion: groupQuestion[i].id
			});
			var groupQuestionNew = {
				isActive: groupQuestion[i].isActive,
				id: groupQuestion[i].id,
				title: groupQuestion[i].title,
				createdAt: groupQuestion[i].createdAt,
				updatedAt: groupQuestion[i].updatedAt,
				numberQuestion: numberQuestion.length
			};
			listResult.push(groupQuestionNew);
		}

		return {
			message: 'Successfully get all Group',
			success: true,
			data: listResult
		};
	} catch (e) {
		return {
			message: 'An error occurred',
			success: false
		};
	}
};
