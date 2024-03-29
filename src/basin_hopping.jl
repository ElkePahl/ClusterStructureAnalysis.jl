include("/home/tyu044/Downloads/CNA/CNA/CNA.jl")
include("/home/tyu044/Downloads/CNA/CNA/comparison.jl")

using .CommonNeighbourAnalysis
using .Comparison
using BenchmarkTools
using Optim
using LinearAlgebra
using Statistics
using Rotations
using DataFrames


sigma=1
x0=[0.0, 0.173, 0.0, 0.15, -0.086, 0.0, -0.15, -0.086, 0.0, 0.0, 0.0, 0.3]
x1=[0.5, 0.5, 0.5, 0.0, 0.0, 0.0, -0.1, 0.2, 0.3, 0.8, 0.0, -0.1]
x2=[0.15, 0.15, 0.0, 0.15, -0.15, 0.0, -0.15, 0.15, 0.0, -0.15, -0.15, 0.0]
x3=[0.0, 0.0, 0.0, 0.0, 0.3, 0.0, 0.26, -0.15, 0.0, -0.26, -0.15, 0.0]
x4=[0.13035618006739527, -0.06989583837781291, 0.0, -0.009998997093929986, 0.20273430218402758, 0.0, 0.42588562691552667, -0.05018769325923475, 0.0, -0.15901119255594903, -0.07869153822013147, 0.0]
x5=[0.1737348645598782, 0.08618476484943655, 0.0, -0.11670021556647546, 0.19919846596915258, 0.0, 0.21962742561183976, -0.22206595336898624, 0.0, -0.0708076548553263, -0.10905225231651632, 0.0]
x13_ico=[2.825384495892464, 0.928562467914040, 0.505520149314310, 2.023342172678102, -2.136126268595355, 0.666071287554958, 2.033761811732818, -0.643989413759464, -2.133000349161121, 0.979777205108572, 2.312002562803556, -1.671909307631893, 0.962914279874254, -0.102326586625353, 2.857083360096907, 0.317957619634043, 2.646768968413408, 1.412132053672896, -2.825388342924982, -0.928563755928189, -0.505520471387560, -0.317955944853142, -2.646769840660271, -1.412131825293682, -0.979776174195320, -2.312003751825495, 1.671909138648006, -0.962916072888105, 0.102326392265998, -2.857083272537599, -2.023340541398004, 2.136128558801072, -0.666071089291685, -2.033762834001679, 0.643989905095452, 2.132999911364582, 0.000002325340981, 0.000000762100600, 0.000000414930733]
x13_hcp=[0.0, 0.0, 0.0, 2.4249, 1.4, 0.0, 0.0, 2.8, 0.0, -2.4249, 1.4, 0.0, -2.4249, -1.4, 0.0, 0.0, -2.8, 0.0, 2.4249, -1.4, 0.0, 0.8083, 1.4, 2.2862, 0.8083, -1.4, 2.2862, -1.6166, 0.0, 2.2652, 0.8083, 1.4, -2.2862, 0.8083, -1.4, -2.2862, -1.6166, 0.0, -2.2652]
x13_2=[3.6372207467053186, 1.8188646106430435, 1.9736693225332198, 2.079165157047173, -0.29724325327599244, 0.42910513150148244, -1.6315616089930074, -1.44384084633954, -3.0669770822208244, 2.545881757889994, 2.32659693214627, -1.0571052105410994, 1.3388552698443368, -0.007689444256998912, 3.350668385693752, 0.6811119489706998, 2.3212499764962726, 1.3702490611701388, -1.8660901288615568, -2.6993467264157287, -0.18607948685926745, 0.8600985409037866, -2.2678076491115338, -1.479600062406953, 0.6580702742615854, -2.694518239329832, 1.6644319472785918, -0.17466211939909146, 0.7313176835100926, -1.3687189142976492, -2.11321061917928, 2.6010690735640463, 0.22237023857076046, -1.0607590909219458, -0.17748752700488024, 1.3840880328099447, -3.2160683749307015, -0.02449016588552146, -0.8575378491575169]
x19=[-0.3515718247,        0.5317889062,       -1.4534155923, 0.3515702741,       -0.5317884317,        1.4534110441, 0.5150259127,        0.9671295617,       -0.8295100638, 0.5887209232,       -0.0999706989,       -1.2377766680,-0.5672515621,        1.1466832051,       -0.5020173851,-0.4480107892,       -0.5799215319,       -1.1626067753,-1.1624411783,        0.1905531188,       -0.7078824655,0.9446085232,        0.3173380210,        0.9464081420,1.0183020493,       -0.7497606704,        0.5381414754,-0.1376672307,        0.4968926224,        1.2739004713,-0.0184288538,       -1.2297096119,        0.6133111560,-0.7328572243,       -0.4592353476,        1.0680353576,0.9406866024,        0.1333540825,       -0.1787522907,0.2315066037,        0.8981672402,        0.2726307409,0.3498702036,       -0.8157499880,       -0.3831049372,-0.7976073753,        0.4217440536,        0.3472483611,-0.7244548212,       -0.6375152295,       -0.0580186080,0.1146600988,       -0.1734354466,        0.4740104578,-0.1146603314,        0.1734361450,       -0.4740124203]
x38_0=[0.1947679907,        0.3306365642,        1.7069272101,1.1592174250,       -1.1514615100,       -0.6254746298,1.4851406793,       -0.0676273830,        0.9223060046,-0.1498046416,        1.4425168343,       -0.9785553065,1.4277261305,        0.3530265376,       -0.9475378022,-0.6881246261,       -1.5737014419,       -0.3328844168,-1.4277352637,       -0.3530034531,        0.9475270683,0.6881257085,        1.5736904826,        0.3329032458,-1.1592204530,        1.1514535263,        0.6254777879,0.1498035273,       -1.4424985165,        0.9785685322,-1.4851196066,        0.0676193562,       -0.9223231092,-0.7057028384,        0.6207073550,       -1.4756523155,-0.8745359533,        0.4648140463,        1.4422103492,-0.9742077067,       -0.8837261792,       -1.1536019836,-0.1947765396,       -0.3306358487,       -1.7069179299,0.3759933035,       -1.7072373106,       -0.0694439840,-1.7124296000,        0.3336352522,        0.1307959669,0.9143159284,        1.3089975397,       -0.7151210582,-0.3759920260,        1.7072300336,        0.0694634263,1.7124281219,       -0.3336312342,       -0.1308207313,-0.9143187026,       -1.3089785474,        0.7151290509,0.9742085109,        0.8837023041,        1.1536069633,0.7057104439,       -0.6206907639,        1.4756502961,0.8745319670,       -0.4648127187,       -1.4422106957,-1.1954804901,       -0.6171923123,       -0.1021449363,0.0917363053,       -1.0144887859,       -0.8848410405,0.9276243144,       -0.8836123311,        0.4234140820,1.1954744473,        0.6171883800,        0.1021399054,-0.9276176774,        0.8836123556,       -0.4234173533,-0.3595942315,       -0.4863167551,        1.2061133825,0.3595891589,        0.4863295901,       -1.2061152849,-0.0917352078,        1.0144694592,        0.8848400639,0.6410702480,       -0.1978633363,       -0.3898095439,-0.4162942817,       -0.0651798741,       -0.6515502084,0.1334019604,        0.7474406294,       -0.1600033264,-0.6410732823,        0.1978593218,        0.3898012337,0.4162968444,        0.0651733322,        0.6515490914, -0.1333998872,       -0.7474445984,        0.1600019961]
x38_1=[1.008361125057741, -0.769633980599810, -0.559171817871104, -0.509096148186660,   1.089162554039077,   1.493257400206362,-0.509096148167876,  -1.083602442204281,  -1.497297057921385,-0.094670886737197,  -0.752474668428163,   0.546704847883737,-0.094670886726391,   0.287419747651941,  -0.884587025672089, 0.437484411864528,   0.587876417632846,   1.809297572314977,-0.509096148166006,   1.089162553975334,  -1.493257400259897,-0.509096148182748,  -1.758865693549359,   0.567876927204396,-1.051607156787838,  -0.983328451416249,   0.000000000013715,-1.051607156782287,   0.795529428237470,  -0.577985961926859, 1.008361125048545,   0.293974021705785,   0.904759006905073,-1.051607156790282,   0.795529428262142,   0.577985961878354,-1.051607156780777,  -0.303865202559347,  -0.935200931379506, -1.051607156793712,  -0.303865202519426,   0.935200931377932, 0.433986584080560,  -0.477568670182377,  -1.469805233980068, 0.433986584078187,   1.250291010396660,  -0.908389591474013,-0.094670886738626,   0.287419747689702,   0.884587025658510, 1.008361125061060,   0.293974021667163,  -0.904759006903675, 1.008361125055377,   0.951319917798398,  -0.000000000013331, 0.437484411867450,  -1.539080442423734,   1.118207395495087,-0.509096148171778,   1.756741919810773,  -0.574413230685629, 0.437484411889554,   0.587876417555611,  -1.809297572334021, 0.437484411882917,  -1.539080442471467,  -1.118207395423336, 1.584073743697131,  -0.000000000001384,   0.000000000010955, 0.437484411878189,   1.902408049704833,  -0.000000000037579, 0.470745098913714,  -0.000000000000411,   0.000000000003256,-0.509096148188586,  -1.083602442140365,   1.497297057960599, 0.433986584069463,  -1.545444680531982,   0.000000000035987, 0.433986584065622,   1.250291010435437,   0.908389591426644,-0.509096148164505,  -0.003436338133663,  -1.848264300362580,-0.509096148179723,   1.756741919835293,   0.574413230603596,-0.509096148174893,  -1.758865693573600,  -0.567876927136356, 0.433986584060231,  -0.477568670119635,   1.469805234006457,-0.509096148190070,  -0.003436338054765,   1.848264300355686,-0.094670886729635,  -0.752474668451500,  -0.546704847852925,-0.094670886731947,   0.930109841538431,  -0.000000000020507, 1.008361125050007,  -0.769633980575941,   0.559171817917904,-0.631627748248736,   0.000000000000551,  -0.000000000004368]
x38_2=[-0.6154250425,       -1.2438603389,        2.2734582848, 2.0037039510,       -0.6525856052,        1.5363631165,  -1.9506677702,      -1.1821592085,       -2.0679415899,  1.5370471862,     -0.9175267921,       -1.2917708706,  0.4892200820,       -1.1820889914,       -1.2186003036,  0.0466279263,        2.2852669732,        0.5919042323, -0.0498117022,       -1.4766908117,       -2.1339787191, 0.8540846687,       -1.4617396600,        0.7755321980,  0.8303300798,       -0.9665284126,        2.1651885266,  2.1469210024,        0.5658035966,       -1.2465544083, -1.5208082016,        1.9563447375,       -0.7654060139, -0.8621689847,        1.3762507087,       -0.6155282012, -0.8148786763,       -0.3155234188,       -0.4026045150, -1.3643190034,       -1.3368232078,       -1.7753920755, -0.6541281183,        0.0934613968,        0.2276738921,  1.1446366860,       -0.3704208910,        2.2432026291, -1.7637604149,       -0.0051013934,        1.0707222421, -0.4151340130,        1.8526972278,        1.6488485450,  0.5978122834,       1.2188646560,       0.9343462189,  0.4813874953,        2.0012398664,       -0.8870183317,  1.9194722010,       -1.7775068599,        0.8591830392, -0.1158573830,        1.9138082181,       -1.4804322356,  0.6688449707,       -0.9804705199,      -0.1454647927, -1.9185018408,        1.3075950417,      -0.6172271182,  2.0181212555,       -0.1089638388,        1.1283805961,  0.0365243987,       -1.9190750326,        1.3357732638, -1.6560234953,       -0.7816104869,        0.4129645575, -1.9016164813,        1.0027629323,        1.8757456218, -1.4446145017,        2.3092169040,       -1.6818117449, -0.2890797503,       -0.4351168218,       -0.0289294988,  1.4516644176,       -0.6360660318,        0.1148914363, -1.1670762172,        0.7211522399,       -0.7859907986,  0.4165029482,       -1.9390140791,        1.2583682134, 1.1180557450,        1.6108913636,        1.4069903347,-0.5724551654,        1.9864182637,        0.3210693508,-1.2596158415,        1.9364713656,        0.3237225121,-0.1446760351,        0.0751037521,       -2.0950681946,0.1099750813,       -1.6634600858,        0.8129423328]
x38_corner=[0.5357358046480165, 1.1133461168272465, 0.011096537372685447, -0.1988451280151944, -0.22931007825486252, -0.8812247563001088, -0.04615809960413057, 0.8544932869034116, 0.9464796484915513, 0.019356536964413116, 1.4345077184903747, -1.8047781367393305, -0.3131916693105723, -1.5284464928900448, -0.034938821528597445, -1.0530542587443716, 0.4241002385375455, -0.5297303288178375, -0.581837783620343, 1.2843402975641467, 0.04223738388358527, 0.13796913275333267, 2.1240285929416562, 0.00896230888338901, 0.633193316140107, 1.703314429049637, -0.9088771618655708, 1.6732318722985835, 0.09234839215117392, -1.1483261483281808, -0.06383198546995737, 0.8569294575096198, -0.8678991684116031, 0.7504377402756258, 0.20027909489682652, -0.550353235735058, 0.7723429016072323, 0.18601097615146728, 0.542591017670917, -0.12114192366269458, 0.3247177117421453, -1.825487486173074, -0.25701854398300994, -0.7858915441467421, -1.8322647422136695, 0.8471576396513336, 0.7652933315806528, -1.4794460675966041, -0.1523536092376555, 0.30418201661844285, 0.035124138757998434, 1.4920288764576153, 1.0146198236498518, 0.5395275561422423, 1.2450865769074404, 1.9587122394294556, -0.007693579385904275, 1.728792092323129, 0.063332537958941, 1.0790430684154206, 0.3205249204712547, -0.6487186573824356, -0.009459926040454916, 1.704256869018672, 0.07801470837571348, -0.03403994559171072, -0.8088840645105188, -0.5394739523605367, 0.02086515602686262, 1.4616032625212279, 1.0281087192323435, -0.578693089523119, -1.0940623755569918, -0.1270750827896031, -1.4881681840388046, 0.27041650253480265, -1.2193481288044141, -0.9444386003148171, 0.7088022954302275, -0.34771739562635384, -1.4933488054302193, 0.7814599103017762, -0.39973132612440054, 1.4570406449478903, -0.9547658082271809, 0.9929647673707483, -1.4739277352322364, 0.31556386226592464, -1.2597017715748429, 0.8865706749044611, -0.8494561904797384, -1.0972652275882293, -0.934106306576861, -1.0460025547526657, 0.40962037576839533, 0.6139235313704389, -0.48051430836345616, 1.8594877440553614, -0.8976501975032848, -0.1857603685776954, -0.273165951733049, 0.9343156011528965, 1.2697240141047346, -0.7919465727977766, 0.5205286264675781, 0.6777110839704973, 1.691156539429215, 0.9196051468436808, 0.9223483365436436, 0.7352601769508763, 1.4678558029971622, 1.2378519119839828, -0.7773432650765408, -0.597639163140864]
x49_0=[-0.8731418328, -0.1910964339, -2.0049734630,2.1481056009,  0.4508419161, -0.0344845237,-1.1409460960,  1.3388585740,  1.3131951849,1.1619453242, -0.9808237523, -1.4620147455,-2.1034221452, -0.0992244121, -0.1240217077,0.8960390917,  0.5381039457,  1.8322581339,-0.6735942517, -1.7925612743, -0.4627847408,-0.8371145795, -0.8584214149,  1.5631790288,1.1710600208, -1.4006163597,  0.7403152541,-0.0003786861,  0.5096103301, -1.9048840676,1.4582465491,  1.3192310973,  0.1463797421,-1.1728988954,  1.5705856000,  0.2141048332,-1.0361055788,  0.7892468579, -1.4804725952,1.5425552946,  0.8374661429, -0.8985328557,-0.2214904438,  1.7727442301,  0.8345693004,1.0296242186,  0.1226875358, -1.6186401926,-1.6456738797,  0.8449720572, -0.5224281502,0.8117682406,  1.3671303493,  1.0803345113,1.6657811687, -0.2685828753, -0.7550827947,1.5315964721,  0.4979410989,  0.9074165337,0.1476280673, -0.5911649551, -1.7452446174,-1.5002726434, -0.1462551972, -1.0700065160,-1.6348496414,  0.6225352772,  0.5973611088,-0.1211370260,  0.9441813911,  1.5846019371,-0.7762256310, -0.9952909611, -1.2385883401,1.6657934063, -0.4764177957,  0.3541221763,-0.9926990061,  0.2413512358,  1.4434377538,0.0293112030, -0.1615891930,  1.7067398056,0.2451308873, -1.3944610101, -0.9671182298,1.1725878484, -1.1973948333, -0.3622199410,-1.4778012603, -0.4818247849,  0.7237869978,-1.3955861750, -0.9514913609, -0.2948260552,1.0389793814, -0.4341980696,  1.2930227255,0.2504815198, -1.6056374355,  0.1390337289,0.1681836224, -1.1355071724,  1.1586481394,-0.7601826005, -1.3327628744,  0.5531599215,0.4455115126,  0.7474351479, -0.9266043904,0.3637141507,  1.2148456330,  0.0871171852,-0.5593141295,  1.0187342793, -0.5148564965,0.0188031345,  0.2242525217, -0.1018847194,1.0605754641,  0.3327405788, -0.0678109958,-0.5489292264,  0.7672880622,  0.5916676508,-0.4178703369,  0.0186055842, -1.0320765286,0.5787712225, -0.3698066377, -0.7669243435,0.4484528945,  0.3746204925,  0.8476082048,-1.0215952194,  0.0622705763, -0.1111679568,0.5818823858, -0.5788864068,  0.3138759184,-0.3206463020, -0.7706546198, -0.2747637827,-0.4006530951, -0.3136106849,  0.7164769738]

N=38


x13_ico=x13_ico/2.782




function distance(x)
    for i=1:N-1
        for j=i+1:N
            println(((x[3j-2]-x[3i-2])^2+(x[3j-1]-x[3i-1])^2+(x[3j]-x[3i])^2)^0.5)
        end
    end
end

function alert(x,R)
    alert=0
    for i=1:N
        if x[3i-2]^2+x[3i-1]^2+x[3i]^2>R^2
            println("x")
            alert+=1
        end
    end
    return alert
end

#println(distance(x38_0))




function lj2(d)
    sig6d6=sigma^6*d^(-3)
        #e=sigma^12*d^(-6)-sigma^6*d^(-3)
    e=sig6d6*(sig6d6-1)
    #if d>=0.9
        #sig6d6=sigma^6*d^(-3)
        #e=sigma^12*d^(-6)-sigma^6*d^(-3)
        #e=sig6d6*(sig6d6-1)
    #else
        #e=0.50993431+7.9720358*(0.9-d)
    #end
    return 4e#/10000
end


function lj(x)
    E=0
    for i=1:N-1
        for j=i+1:N
            E+=lj2((x[3*j-2]-x[3*i-2])^2+(x[3*j-1]-x[3*i-1])^2+(x[3*j]-x[3*i])^2)
        end
    end
    return E
end

println(lj(x38_1))


function max_distance(x)
    center=center_of_mass(x)
    max=((x[1]-center[1])^2+(x[2]-center[2])^2+(x[3]-center[3])^2)^0.5
    for i=2:N
        dist=((x[3i-2]-center[1])^2+(x[3i-1]-center[2])^2+(x[3i]-center[3])^2)^0.5
        if dist>max
            max=dist
        end
    end
    return max
end

c6=-0.132
c8=-1.5012
c9=35.6955
c10=-268.7494
c11=729.7605
c12=-583.4203

a6=0.0005742
a8=-0.4032
a9=-0.2101
a10=-0.0595
a11=0.0606
a12=0.1608

b6=-0.01336
b8=-0.02005
b9=-0.1051
b10=-0.1268
b11=-0.1405
b12=-0.1751

function elj2(d,theta)
    e=c6*(1+a6*cos(2*theta)+b6*cos(4*theta))*d^(-6)+c8*(1+a8*cos(2*theta)+b8*cos(4*theta))*d^(-8)+c9*(1+a9*cos(2*theta)+b9*cos(4*theta))*d^(-9)+c10*(1+a10*cos(2*theta)+b10*cos(4*theta))*d^(-10)+c11*(1+a11*cos(2*theta)+b11*cos(4*theta))*d^(-11)+c12*(1+a12*cos(2*theta)+b12*cos(4*theta))*d^(-12)
    #e=c6*(1+a6+b6)*d^(-6)+c8*(1+a8+b8)*d^(-8)+c9*(1+a9+b9)*d^(-9)+c10*(1+a10+b10)*d^(-10)+c11*(1+a11+b11)*d^(-11)+c12*(1+a12+b12)*d^(-12)
    return e
end

println(elj2(3.78,0))
println(elj2(2.782,pi/2))


function elj(x)
    E=0
    for i=1:N-1
        for j=i+1:N
            theta=atan(((x[3*j-2]-x[3*i-2])^2+(x[3*j-1]-x[3*i-1])^2)^0.5/abs(x[3*j]-x[3*i]))
            E+=elj2(((x[3*j-2]-x[3*i-2])^2+(x[3*j-1]-x[3*i-1])^2+(x[3*j]-x[3*i])^2)^0.5,theta)
        end
    end
    return E
end

#println(elj(x13_ico))




#result1 = optimize(lj, x, Optim.Options(iterations=100000,store_trace = true,show_trace = false))
#@btime optimize(lj, x0)

#println("Nelder-Mead")
#println(result1.minimizer)
#println(result1)
#distance(result1.minimizer)
#println("----------------------------------------------------------------------------------")


function summation(dist,x)
    a=zeros(3N)
    for i=1:N
        for j=1:N
            if i==j
                continue
            else
                a[3i-2]+=6*sigma^6*dist[i,j]^(-4)*(x[3i-2]-x[3j-2])*(-2*sigma^6*dist[i,j]^(-3)+1)
                #-12*sigma^12*dist[i,j]^(-7)*(x[3i-2]-x[3j-2])+6*sigma^6*dist[i,j]^(-4)*(x[3i-2]-x[3j-2])
                a[3i-1]+=6*sigma^6*dist[i,j]^(-4)*(x[3i-1]-x[3j-1])*(-2*sigma^6*dist[i,j]^(-3)+1)
                a[3i]+=6*sigma^6*dist[i,j]^(-4)*(x[3i]-x[3j])*(-2*sigma^6*dist[i,j]^(-3)+1)
            end
        end
    end
    return(4a)
end


function gradients!(storage, x)
    dist=zeros(N,N)
    for i=1:N-1
        for j=i+1:N
            dist[i,j]=(x[3*j-2]-x[3*i-2])^2+(x[3*j-1]-x[3*i-1])^2+(x[3*j]-x[3*i])^2
        end
    end
    dist_full=Symmetric(dist)

    for i=1:3N
        storage[i]=summation(dist_full,x)[i]
    end
end


function gradients!(x)
    storage=zeros(3N)
    dist=zeros(N,N)
    for i=1:N-1
        for j=i+1:N
            dist[i,j]=(x[3*j-2]-x[3*i-2])^2+(x[3*j-1]-x[3*i-1])^2+(x[3*j]-x[3*i])^2
        end
    end
    dist_full=Symmetric(dist)
    println(dist_full)
    for i=1:N
        for j=1:N
            if i==j
                continue
            else
                storage[3i-2]+=-12*sigma^12*dist_full[i,j]^(-7)*(x[3i-2]-x[3j-2])+6*sigma^6*dist_full[i,j]^(-4)*(x[3i-2]-x[3j-2])
                storage[3i-1]+=-12*sigma^12*dist_full[i,j]^(-7)*(x[3i-1]-x[3j-1])+6*sigma^6*dist_full[i,j]^(-4)*(x[3i-1]-x[3j-1])
                storage[3i]+=-12*sigma^12*dist_full[i,j]^(-7)*(x[3i]-x[3j])+6*sigma^6*dist_full[i,j]^(-4)*(x[3i]-x[3j])
            end
        end
    end
    println(storage)
end



#od=OnceDifferentiable(lj,x; autodiff=:forward);
#od=OnceDifferentiable(f,zeros(2); autodiff=:forward);
#od=OnceDifferentiable(lj,x; autodiff=:forward);

println("Conjugate Gradient")


function displacement!(radius,r,displacement)
    d=zeros(3N)
    for i=1:3N
        d[i]=displacement*(1-2*rand())
        r[i]=r[i]+d[i]
    end
    for j=1:N
        if (r[3j-2]^2+r[3j-1]^2+r[3j]^2)>radius^2
            for k=0:2
                r[3j-k]=r[3j-k]-d[3j-k]
            end
        end
    end
end

function center_of_mass(r)
    center=zeros(3)
    for i=1:N
        for j=1:3
            center[j]+=r[3i-3+j]/N
        end
    end
    return center
end

function rotation!(r)
    select=rand(1:N)
    center=center_of_mass(r)
    r_re=zeros(3)     #coordinates relative to the center of mass
    rr=zeros(3,3)     #random rotation
    for i=1:3
        r_re[i]=r[3*select-3+i]-center[i]
    end
    rr = rand(RotMatrix{3})
    for i=1:3
        r[3*select-3+i]=(rr*r_re)[i]+center[i]
    end
end

function twist!(max,r)
    axis=zeros(3)
    for i=1:3
        axis[i]=rand()*max
    end
    length=(axis[1]^2+axis[2]^2+axis[3]^2)^0.5
    axis_n=axis/length
    raa=AngleAxis(2π*rand(), axis_n[1], axis_n[2], axis_n[3])
    for i=1:N
        if r[3i-2]*axis[1]+r[3i-1]*axis[2]+r[3i]*axis[3]>length
            r_twist=raa*[r[3i-2],r[3i-1],r[3i]]
            for j=1:3
                r[3i-3+j]=r_twist[j]
            end
        end
    end
end


function one_atom_energy(i,r)
    e=0
    for j=1:N
        if j==i
            continue
        else
            e+=lj2((r[3*j-2]-r[3*i-2])^2+(r[3*j-1]-r[3*i-1])^2+(r[3*j]-r[3*i])^2)
        end
    end
    return e
end


function one_atom_energies(r)
    e=zeros(N)
    for i=1:N
        e[i]=one_atom_energy(i,r)
    end
    return e
end



function to_surface!(r)
    r_c=center_of_mass(r)
    max_distance=((r[1]-r_c[1])^2+(r[2]-r_c[2])^2+(r[3]-r_c[3])^2)^0.5
    for i=2:N
        d=((r[3i-2]-r_c[1])^2+(r[3i-1]-r_c[2])^2+(r[3i]-r_c[3])^2)^0.5
        if d>max_distance
            max_distance=d
        end
    end
    select=findmax(one_atom_energies(r))[2]
    theta=rand()*pi
    phi=rand()*2pi
    r[3*select-2]=max_distance*cos(phi)*sin(theta)+r_c[1]
    r[3*select-1]=max_distance*sin(phi)*sin(theta)+r_c[2]
    r[3*select]=max_distance*cos(theta)+r_c[3]
end


function to_center!(r,radius)
    distances2=zeros(N)
    r_c=center_of_mass(r)
    for i=1:N
        distances2[i]=(r[3i-2]-r_c[1])^2+(r[3i-1]-r_c[2])^2+(r[3i]-r_c[3])^2
    end
    select=findmax(distances2)[2]
    theta=rand()*pi
    phi=rand()*2pi
    r[3*select-2]=radius*cos(phi)*sin(theta)*0.05+r_c[1]
    r[3*select-1]=radius*sin(phi)*sin(theta)*0.05+r_c[2]
    r[3*select]=radius*cos(theta)*0.05+r_c[3]
end

println(1)

radius=2^(1/6)*(0.5+(3*N/4/pi/2^0.5)^(1/3))*sigma
println("r=",radius)
displacement=0.4
BHstep=2
BH=1
T=500000
T_cg=10
x=x38_0
println("initial energy = ",lj(x))
od=OnceDifferentiable(lj,x; autodiff=:forward);
result1 = Optim.minimizer(optimize(od, x, ConjugateGradient(),Optim.Options(g_tol=1e-6)))
println("after minimizatoon ",lj(result1))
for k=1:N
    println(10," ",result1[3k-2]," ",result1[3k-1]," ",result1[3k])
end
for i=1:3N
    x[i]=result1[i]
end
#x=x13_ico
#energies=zeros(BHstep)
energies=DataFrame(A=Float64[])
configurations=Array{Array}(undef,BHstep) 
Emin=-1.8
Emax=0.


energies_array=zeros(BHstep)
similarities=zeros(BHstep)
regions=zeros(6,2)
transitions=zeros(12,12)

count_cluster=0

config_1=Array{Float64}(undef,N,3)
for i=1:N
	for j=1:3
		config_1[i,j]=x38_0[3i-(3-j)]
	end
end
println("initial total CNA profile is")
println(CNA(config_1, N, 1.3549, true, sigma)[1])
println(CNA(config_1, N, 1.3549, true, sigma)[2])

config_2=Array{Float64}(undef,N,3)
for i=1:N
	for j=1:3
		config_2[i,j]=x38_1[3i-(3-j)]
	end
end
println("initial total CNA profile of the icosohedral config is")
println(CNA(config_2, N, 1.3549, true, sigma)[1])
println(CNA(config_2, N, 1.3549, true, sigma)[2])

totalProfile = Dict{String,Int}()
totalProfile_1 = Dict{String,Int}() 
totalProfile_1 = CNA(config_1, N, 1.3549, true, sigma)[1]
atomicProfile_1 = [Dict{String,Int}() for i in 1:N]
atomicProfile_1 = CNA(config_1, N, 1.3549, true, sigma)[2]

println(similarityScore_one(1, 2, [totalProfile_1,CNA(config_2, N, 1.3549, true, sigma)[1]],[atomicProfile_1,CNA(config_2, N, 1.3549, true, sigma)[2]],"total",N,))
#println(similarityScore_one(1, 2, [CNA(config_1, N, 1.3549, false, 1.122)[1],CNA(config_2, N, 1.3549, false, 1.122)[1]],[CNA(config_1, N, 1.3549, false, 1.122)[2],CNA(config_2, N, 1.3549, false, 1.122)[2]],"atomic",N))


energy=lj(x)
finalenergy=energy
e_end=energy
final_e_end=energy
final_x=copy(x)
final_x_end=copy(x)
acceptance=0
accepted=0
acceptance_cg=0


for i=1:BHstep
    global e_index,n_print,e_end
    println(i)
    for j=1:BH
        global energy, acceptance, accepted, finalenergy
        #println("initial energy= ", elj(x))
        finalenergy=final_e_end
        #println("final_e_end'= ", final_e_end)
        #println(finalenergy)
        e_index=0
        operator_select=rand(1:100)
        if operator_select<=80
            displacement!(radius, x, displacement)
        elseif operator_select<=85
            rotation!(x)
        elseif operator_select<=90
            twist!(radius-1,x)
        elseif operator_select<=95
            to_surface!(x)
        else
            to_center!(x,radius)
        end
        energy=lj(x)
        #println("energy after pertubation= ",energy)
        #println("final energy= ",finalenergy)
        #println(acceptance)
        ra=rand()
        acceptance=exp((finalenergy-energy)/T)
        #println(acceptance)
        if ra<acceptance && max_distance(x)<radius
            accepted+=1
            finalenergy=energy
            for k=1:3N
                final_x[k]=x[k]
            end
        else
            energy=finalenergy
            for k=1:3N
                x[k]=final_x[k]
            end
        end
    end
    for k=1:N
        println("Ne"," ",x[3k-2]," ",x[3k-1]," ",x[3k])
    end

    #println("energy before minimization is ",elj(x))
    local od
    od=OnceDifferentiable(lj,x; autodiff=:forward);
    println("enenrgy before minimization is ", lj(x))
    result2 = Optim.minimizer(optimize(od, x, ConjugateGradient(),Optim.Options(g_tol=1e-3,show_trace=false)))
    e_end=lj(result2)
    println("enenrgy after minimization is ", e_end)
    if e_end<-1.73
        #println(result2)
        for k=1:N
            println(10," ",result2[3k-2]," ",result2[3k-1]," ",result2[3k])
        end
    end
    if e_end>Emin && e_end<Emax
        #println("new initial configuration suggested")
        global acceptance_cg, final_e_end
        #Ehistogram[Int(floor((e_end-Emin)/dE+1))]+=1
        #println(final_e_end)
        #println(e_end)
        acceptance_cg=exp((final_e_end-e_end)/T_cg)
        #println(acceptance_cg)
        ra=rand()
        if ra<acceptance_cg
            #println("new initial configuration accepted")
            final_e_end=e_end
            for k=1:3N
                #x[k]=result2[k]
                final_x[k]=result2[k]
                final_x_end[k]=result2[k]
            end
        else
            en_end=final_e_end
        end
    else
        e_end=final_e_end
    end
    for k=1:3N
        x[k]=result2[k]=final_x_end[k]
    end

    alert(result2, radius+1)
    if alert(result2, radius+1)>=1
        println("out")
        for k=1:3N
            x[k]=result1[k]
            final_x[k]=result1[k]
            final_x_end[k]=result1[k]
        end
        #println("resetted coordinates last round")
        #for k=1:N
            #println(10," ",x[3k-2]," ",x[3k-1]," ",x[3k])
        #end
        energy=e_end=final_e_end=lj(result1)
    else
        count_cluster+=1
        config=Array{Float64}(undef,N,3)
        for i=1:N
	        for j=1:3
		        config[i,j]=x[3i-(3-j)]
	        end
        end
        #totalProfile=CNA(config, N, 1.3549, true, sigma)[1]
        #println(totalProfile)
        #println(CNA(config, N, 1.3549, true, sigma)[2])
        #similarity=similarityScore_one(1, 2, [totalProfile_1,totalProfile],[atomicProfile_1,CNA(config, N, 1.3549, true, sigma)[2]],"total",N,)
        #println(similarity)
        #energies_array[count_cluster]=final_e_end
        #similarities[count_cluster]=similarity

    end

    #println("final_e_end= ",final_e_end)
    #println("new initial energy should be", elj(final_x_end))
    #println()
    #println("38")
    #println()
    #println(e_end)
    #println()
    #println()
    #println()

    #result2 = optimize(lj, gradients!, x, ConjugateGradient(),Optim.Options(iterations=1000,store_trace = true,show_trace = false))
    #println(result2)
    #configurations[i]=result2.minimizer
    #for k=1:N

        #println(18," ",result2.minimizer[3k-2]," ",result2.minimizer[3k-1]," ",result2.minimizer[3k])
    #end
    #alert(result2.minimizer, radius+4)

    #push!(energies,[result2.minimum])
    #for j=1:i-1
        #if abs(energies.A[i]-energies.A[j])<0.001 && abs(energies.A[i]-energies.A[j])>0.0000001
            #println(abs(energies.A[i]-energies.A[j]))
            #println(j," , ",i)
            #println(energies.A[j]," , ",energies.A[i])
            #for k=1:N
                #println(18," ",configurations[j][3k-2]," ",configurations[j][3k-1]," ",configurations[j][3k])
            #end
            #println("----------------------------------------------------------------------------------")
            #for k=1:N
                #println(18," ",configurations[i][3k-2]," ",configurations[i][3k-1]," ",configurations[i][3k])
            #end
            #println(lj(configurations[i]))
            #println(lj(configurations[j]))
            #println()
            #println()
            #println()
        #end
    #end
    #println("----------------------------------------------------------------------------------")
end

energies_cluster=zeros(count_cluster)
similarities_cluster=zeros(count_cluster)

println(accepted)
println(count_cluster)

for i=1:count_cluster
    energies_cluster[i]=energies_array[i]
    similarities_cluster[i]=similarities[i]
end

println(energies_cluster)
println(similarities_cluster)
println(regions)
println(transitions)