import React from 'react';
import ContactInfo from './components/ContactInfo';

import HeroWrap from './components/HeroWrap';

interface ContactProps {}

export const Contact = (props: ContactProps) => {
	return (
		<div>
			<HeroWrap />
			<ContactInfo />
		</div>
	);
};
