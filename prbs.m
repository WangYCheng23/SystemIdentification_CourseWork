function y = prbs(N);
%%% generates prbs sequence of ones and zeros
%%% see Numerical recipes p209ff

if N == 2,
	mpol = [2 1];
elseif N == 3,
	mpol = [3 1];
elseif N == 4,
	mpol = [4 1];
elseif N == 5,
	mpol = [5 2];
elseif N == 6,
	mpol = [6 1];
elseif N == 7,
	mpol = [7 1];
elseif N == 8,
	mpol = [8 4 3 2];
elseif N == 9,
	mpol = [9 4];
elseif N == 10,
	mpol = [10 3];
elseif N == 11,
	mpol = [11 2];
elseif N == 12,
	mpol = [12 6 4 1];
else
	disp('false entry')
	mpol = [];
end



register = zeros(N,1);
register(N,1) = 1;

y = zeros(2^N-1,1);

S = size(mpol,2);

for j = 1:2^N-1,

	y(j) = register(mpol(1));

	for k = 2:S,
		register(mpol(k)) = xor(register(mpol(k)),y(j));
	end

	register = [y(j);register(1:N-1)];




end