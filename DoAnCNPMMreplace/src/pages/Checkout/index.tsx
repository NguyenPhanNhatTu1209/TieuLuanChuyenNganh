import React from 'react';
import CheckoutInfo from './components/CheckoutInfo';
import HeroWrap from './components/HeroWrap';

interface Props {}

const CheckoutPage = (props: Props) => {
	return (
		<div>
			<HeroWrap />
			<CheckoutInfo />
		</div>
	);
};

export default CheckoutPage;
