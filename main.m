% CANDU UO2 VERSUS LIGHTBRIDGE U-50Zr
% Developed by Geoffrey Momin
% Requires Data Table.csv
% ********Updates********
% February 29, 2016 - release

% Import the CSV and define the values for the molar masses, avogadro's
% number, and microscopic cross section of fission for U235 neutrons.

CSV = csvread('data table.csv',1,1,[1,1,12,5]);
M_U235 = 235.043923062;
M_U238 = 238.050782583;
M_O = 15.9994;
M_Zr = 105.93591;
A = 6.022*10^23;
micro_fission = 582.6*10^-24;


prompt = 'What fission cross section are you interested in? ';
i = input(prompt); %obtain an input value

mole_weight = 1/((CSV(i,2)/M_U235)+(CSV(i,1)/M_U238));
enrich_density = mole_weight/(mole_weight + (CSV(i,3)*M_O)+(CSV(i,4)*M_Zr));
N = ((CSV(i,2)*CSV(i,5)*A)/(M_U235))*enrich_density;
macro_fission = N * micro_fission;
disp(macro_fission);
