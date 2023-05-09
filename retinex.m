function I0 = retinex(img)
%RETINEX �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

sigma=250;	% ��˹�˲����ı�׼����ʵ�����

if size(img,3)>1	% �����ɫͼ��
	for k=1:3
	R=img(:,:,k);
	[N1,M1]=size(R);
	F=zeros(N1,M1);%�����˹�˲�����
	for i=1:N1
	    for j=1:M1
	   F(i,j)=exp(-((i-N1/2)^2+(j-M1/2)^2)/(2*sigma*sigma));
	    end
	end
	F = F./(sum(F(:)));
	R0=double(R);%R�ŵ�
	Rlog=log(R0+1);%ȡ����
	Rfft2=fft2(R0);%����Ҷ��ά
	Ffft2=fft2(double(F));%��˹�˲���ά����Ҷ
	DR0=Rfft2.*Ffft2;%Ƶ�����˹�˲�
	DR=ifft2(DR0);%�˲���ռ������ͼ��
	DRdouble=double(DR);
	DRlog=log(DRdouble+1);%����õ���Ƶ����
	Rr=Rlog-DRlog;
	EXPRr=exp(Rr);
	MIN = min(min(EXPRr));
	MAX = max(max(EXPRr));
	EXPRr = (EXPRr-MIN)/(MAX-MIN);
	EXPRr=adapthisteq(EXPRr);
	I0(:,:,k)=EXPRr;
	end
else	% ����Ҷ�ͼ��
	R=img;
	[N1,M1]=size(R);
	F=zeros(N1,M1);%�����˹�˲�����
	for i=1:N1
	    for j=1:M1
	   F(i,j)=exp(-((i-N1/2)^2+(j-M1/2)^2)/(2*sigma*sigma));
	    end
	end
	F = F./(sum(F(:)));
	R0=double(R);%R�ŵ�
	Rlog=log(R0+1);%ȡ����
	Rfft2=fft2(R0);%����Ҷ��ά
	Ffft2=fft2(double(F));%��˹�˲���ά����Ҷ
	DR0=Rfft2.*Ffft2;%Ƶ�����˹�˲�
	DR=ifft2(DR0);%�˲���ռ������ͼ��
	DRdouble=double(DR);
	DRlog=log(DRdouble+1);%����õ���Ƶ����
	Rr=Rlog-DRlog;
	EXPRr=exp(Rr);
	MIN = min(min(EXPRr));
	MAX = max(max(EXPRr));
	EXPRr = (EXPRr-MIN)/(MAX-MIN);
	EXPRr=imadjust(adapthisteq(EXPRr));
	I0=EXPRr;
end
%%%
% subplot(121),imshow(img), title('ԭͼ');
% subplot(122),imshow(I0), title('Retinex');

end

