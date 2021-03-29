close all; clear all; clc
t1 = [0.6;0.1;1;0];
t2 = [0.2;0.3;0;1];
Net = [0.1;0;0.3;-0.2;0.2;-0.4;-0.4;0.2;0.1;-0.1;0.6;-0.2;0.1;0.2;0.5;-0.1;0.6];
l = 0.1;
firstNet = Ann(t1,Net,l)
secondNet = Ann(t2,firstNet,l)
function ANN = Ann(T,Net,l)
O1 = T(1);
O2 = T(2);
w13 = Net(1);
w14 = Net(2);
w15 = Net(3);
w23 = Net(4);
w24 = Net(5);
w25 = Net(6);
w36 = Net(7);
w37 = Net(8);
w46 = Net(9);
w47 = Net(10);
w56 = Net(11);
w57 = Net(12);
theta3 = Net(13);
theta4 = Net(14);
theta5 = Net(15);
theta6 = Net(16);
theta7 = Net(17);
I3 = O1 * w13 + O2 * w23 + theta3;
O3 = cO(I3);
I4 = O1 * w14 + O2 * w24 + theta4;
O4 = cO(I4);
I5 = O1 * w15 + O2 * w25 + theta5;
O5 = cO(I5);
I6 = O3 * w36 + O4 * w46 + O5 * w56 + theta6;
O6 = cO(I6);
I7 = O3 * w37 + O4 * w47 + O5 * w57 + theta7;
O7 = cO(I7);
E6 = cOE(T(3),O6);
E7 = cOE(T(4),O7);
E3 = cHE(O3,w36,w37,E6,E7);
E4 = cHE(O4,w46,w47,E6,E7);
E5 = cHE(O5,w56,w57,E6,E7);
newNet = [
    uW(w13,E3,O1,l);
    uW(w14,E4,O1,l);
    uW(w15,E5,O1,l);
    uW(w23,E3,O2,l);
    uW(w24,E4,O2,l);
    uW(w25,E5,O2,l);
    uW(w36,E6,O3,l);
    uW(w37,E7,O3,l);
    uW(w46,E6,O4,l);
    uW(w47,E7,O4,l);
    uW(w56,E6,O5,l);
    uW(w57,E7,O5,l);
    uB(theta3,E3,l);
    uB(theta4,E4,l);
    uB(theta5,E5,l);
    uB(theta6,E6,l);
    uB(theta7,E7,l);];
ANN = newNet;
end

function calculateOutput = cO(I)
calculateOutput = 1/(1+exp(-I));
end

function calOutputErr = cOE(c,o)
calOutputErr = o * (1-o) * (c - o);
end

function calHiddenErr = cHE(o,wi6,wi7,E6,E7)
calHiddenErr = o * (1-o) * (E6 * wi6 + E7 * wi7);
end

function updateWeight = uW(wij,Ej,Oi,l)
updateWeight = wij + l* Ej * Oi;
end

function updateBias = uB(thetaj,Ej,l)
updateBias = thetaj + l * Ej;
end