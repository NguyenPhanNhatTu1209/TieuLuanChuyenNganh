import React from 'react';
import HeroWrap from './components/HeroWrap';
import WhishListInfo from './components/WishListInfo';

interface Props {}

const WishListPage = (props: Props) => {
	return (
		<div>
			<HeroWrap />
			<WhishListInfo />
		</div>
	);
};

export default WishListPage;
