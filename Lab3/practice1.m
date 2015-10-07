% generating noise with prob function
s1=100;
s2=100;
noise(1:s1,1:s2)=0;
u=0;sigma=2;
random=randn([s1,s2]);abs_r=abs(random);
max_random=max(abs_r(:));
random=random/max_random*500;
mean_random=mean(random(:));
random=random-mean_random;
random=floor(random);

for i=1:s1
    for j=1:s2
        noise(i,j)=1/sqrt(2*pi*sigma*sigma)*exp(-1*random(i,j)*random(i,j)/(2*pi*sigma^2));
        
    end
end

bins=50;
figure;
hist(noise(:),bins);title('Poisson noise');