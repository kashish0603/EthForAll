import React from "react";
import "../Product/Product.css";

export const Product = (props) => {
	return (
		<>
			<a href="#">
				<div className="card">
					<div className="img-vet">
						<img
							src={props.logo}
							alt="vet-img"
							height="175px"
							width="100%"
						/>
					</div>
					<div className="info">
						<h3>{props.name}</h3>
						<h4>Minimum investment: {props.min} /-</h4>
						<h5>{props.desc}</h5>
					</div>
				</div>
			</a>
		</>
	);
};
