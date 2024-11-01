//
//  MedicineList.swift
//  hms-structured
//
//  Created by srijan mishra on 30/04/24.
//
//
//  MedicineList.swift
//  hms
//
//  Created by srijan mishra on 24/04/24.
//


import Foundation

struct Medicine: Identifiable {
    let id = UUID()
    let name: String
    let details: String
    var medicineDetails = MedicineDetails()
}

let medicineList: [Medicine] = [
    Medicine(name: "Paracetamol", details: "For fever and pain relief"),
    Medicine(name: "Amoxicillin", details: "Antibiotic for bacterial infections"),
    Medicine(name: "Lisinopril", details: "For high blood pressure"),
    Medicine(name: "Omeprazole", details: "For acidity and gastric ulcers"),
    Medicine(name: "Atorvastatin", details: "For lowering cholesterol levels"),
    Medicine(name: "Metformin", details: "For type 2 diabetes"),
    Medicine(name: "Ciprofloxacin", details: "Broad-spectrum antibiotic"),
    Medicine(name: "Ibuprofen", details: "Nonsteroidal anti-inflammatory drug (NSAID)"),
    Medicine(name: "Ranitidine", details: "For acidity and gastric ulcers"),
    Medicine(name: "Amlodipine", details: "For high blood pressure and angina"),
    Medicine(name: "Diazepam", details: "Anxiolytic and sedative-hypnotic drug"),
    Medicine(name: "Aspirin", details: "For pain relief and as an antiplatelet agent"),
    Medicine(name: "Cetirizine", details: "Antihistamine for allergies"),
    Medicine(name: "Alprazolam", details: "For anxiety disorders"),
    Medicine(name: "Prednisolone", details: "Corticosteroid for various inflammatory conditions"),
    Medicine(name: "Levofloxacin", details: "Antibiotic for bacterial infections"),
    Medicine(name: "Furosemide", details: "Diuretic for treating edema and hypertension"),
    Medicine(name: "Pantoprazole", details: "For acidity and gastric ulcers"),
    Medicine(name: "Losartan", details: "For high blood pressure and diabetic kidney disease"),
    Medicine(name: "Clarithromycin", details: "Antibiotic for bacterial infections"),
    // Add more medicines as needed
    Medicine(name: "Montelukast", details: "For asthma and allergic rhinitis"),
    Medicine(name: "Esomeprazole", details: "For acidity and gastric ulcers"),
    Medicine(name: "Fluoxetine", details: "For depression and anxiety disorders"),
    Medicine(name: "Simvastatin", details: "For lowering cholesterol levels"),
    Medicine(name: "Gliclazide", details: "For type 2 diabetes"),
    Medicine(name: "Doxycycline", details: "Broad-spectrum antibiotic"),
    Medicine(name: "Naproxen", details: "Nonsteroidal anti-inflammatory drug (NSAID)"),
    Medicine(name: "Famotidine", details: "For acidity and gastric ulcers"),
    Medicine(name: "Valsartan", details: "For high blood pressure and heart failure"),
    Medicine(name: "Lorazepam", details: "Anxiolytic and sedative-hypnotic drug"),
    Medicine(name: "Clopidogrel", details: "Antiplatelet agent for preventing blood clots"),
    Medicine(name: "Diphenhydramine", details: "Antihistamine for allergies and sleep aid"),
    Medicine(name: "Pregabalin", details: "For neuropathic pain and epilepsy"),
    Medicine(name: "Methylprednisolone", details: "Corticosteroid for various inflammatory conditions"),
    Medicine(name: "Azithromycin", details: "Antibiotic for bacterial infections"),
    Medicine(name: "Hydrochlorothiazide", details: "Diuretic for hypertension and edema"),
    Medicine(name: "Rabeprazole", details: "For acidity and gastric ulcers"),
    Medicine(name: "Valsartan + Hydrochlorothiazide", details: "Combination for high blood pressure"),
    Medicine(name: "Metoprolol", details: "Beta blocker for high blood pressure and angina"),
    Medicine(name: "Cephalexin", details: "Antibiotic for bacterial infections"),
    Medicine(name: "Nifedipine", details: "Calcium channel blocker for high blood pressure and angina"),
    Medicine(name: "Meloxicam", details: "Nonsteroidal anti-inflammatory drug (NSAID)"),
    Medicine(name: "Clonazepam", details: "For panic disorder and seizures"),
    Medicine(name: "Fentanyl", details: "Opioid analgesic for severe pain"),
    Medicine(name: "Levothyroxine", details: "Thyroid hormone replacement therapy"),
    Medicine(name: "Lansoprazole", details: "For acidity and gastric ulcers"),
    Medicine(name: "Glibenclamide", details: "For type 2 diabetes"),
    Medicine(name: "Cefixime", details: "Antibiotic for bacterial infections"),
    Medicine(name: "Warfarin", details: "Anticoagulant for preventing blood clots"),
    Medicine(name: "Escitalopram", details: "For depression and anxiety disorders"),
    Medicine(name: "Sildenafil", details: "For erectile dysfunction"),
    Medicine(name: "Gabapentin", details: "For neuropathic pain and epilepsy"),
    Medicine(name: "Citalopram", details: "For depression and anxiety disorders"),
    Medicine(name: "Clotrimazole", details: "Antifungal medication"),
    Medicine(name: "Tramadol", details: "Opioid analgesic for moderate to severe pain"),
    Medicine(name: "Diclofenac", details: "Nonsteroidal anti-inflammatory drug (NSAID)"),
    Medicine(name: "Amitriptyline", details: "Tricyclic antidepressant"),
    Medicine(name: "Metronidazole", details: "Antibiotic and antiprotozoal medication"),
    Medicine(name: "Doxazosin", details: "Alpha blocker for hypertension and benign prostatic hyperplasia"),
    Medicine(name: "Carvedilol", details: "Beta blocker for heart failure and hypertension"),
    Medicine(name: "Nortriptyline", details: "Tricyclic antidepressant"),
    Medicine(name: "Isosorbide Mononitrate", details: "For angina and heart failure"),
    Medicine(name: "Hyoscine Butylbromide", details: "For abdominal cramps and irritable bowel syndrome"),
    Medicine(name: "Metronidazole + Norfloxacin", details: "Combination for bacterial infections"),
    Medicine(name: "Ondansetron", details: "For nausea and vomiting"),
    Medicine(name: "Mebendazole", details: "Anthelmintic medication for worm infections"),
    Medicine(name: "Fluticasone", details: "Inhaled corticosteroid for asthma and COPD"),
    Medicine(name: "Mupirocin", details: "Topical antibiotic for skin infections"),
    Medicine(name: "Duloxetine", details: "For depression and neuropathic pain"),
    Medicine(name: "Budesonide", details: "Inhaled corticosteroid for asthma and COPD"),
    Medicine(name: "Ezetimibe", details: "For lowering cholesterol levels"),
    Medicine(name: "Dexamethasone", details: "Corticosteroid for various inflammatory conditions"),
    Medicine(name: "Nifedipine (topical)", details: "For anal fissures and Raynaud's phenomenon"),
    Medicine(name: "Venlafaxine", details: "For depression and anxiety disorders"),
    Medicine(name: "Ethinyl Estradiol + Levonorgestrel", details: "Combined oral contraceptive pill"),
    Medicine(name: "Propranolol", details: "Beta blocker for high blood pressure and migraines"),
    Medicine(name: "Mirtazapine", details: "Atypical antidepressant"),
    Medicine(name: "Terbinafine", details: "Antifungal medication"),
    Medicine(name: "Fexofenadine", details: "Antihistamine for allergies"),
    Medicine(name: "Naproxen + Esomeprazole", details: "Combination for arthritis and gastric protection"),
    Medicine(name: "Pioglitazone", details: "For type 2 diabetes"),
    Medicine(name: "Hydrocortisone", details: "Topical corticosteroid for skin inflammation"),
    Medicine(name: "Nifedipine (oral)", details: "Calcium channel blocker for high blood pressure and angina"),
    Medicine(name: "Clobetasol", details: "Topical corticosteroid for skin inflammation"),
    Medicine(name: "Miconazole", details: "Antifungal medication"),
    Medicine(name: "Tadalafil", details: "For erectile dysfunction and pulmonary arterial hypertension"),
    Medicine(name: "Furosemide + Spironolactone", details: "Combination for edema and heart failure"),
    Medicine(name: "Cefuroxime", details: "Antibiotic for bacterial infections"),
    Medicine(name: "Erythromycin", details: "Antibiotic for bacterial infections"),
    Medicine(name: "Desloratadine", details: "Antihistamine for allergies"),
    Medicine(name: "Acyclovir", details: "Antiviral medication for herpes infections"),
    Medicine(name: "Metronidazole (topical)", details: "For acne and rosacea"),
    Medicine(name: "Tamsulosin", details: "Alpha blocker for benign prostatic hyperplasia"),
    Medicine(name: "Folic Acid", details: "Vitamin supplement"),
    Medicine(name: "Nitroglycerin", details: "For angina"),
    Medicine(name: "Aripiprazole", details: "Atypical antipsychotic"),
    Medicine(name: "Desvenlafaxine", details: "For depression and anxiety disorders"),
    Medicine(name: "Melatonin", details: "For sleep disorders"),
    Medicine(name: "Mometasone", details: "Topical corticosteroid for skin inflammation"),
    Medicine(name: "Amikacin", details: "Antibiotic for bacterial infections"),
    Medicine(name: "Chlorpheniramine", details: "Antihistamine for allergies"),
    Medicine(name: "Spironolactone", details: "Diuretic for hypertension and edema"),
    Medicine(name: "Terazosin", details: "Alpha blocker for high blood pressure and benign prostatic hyperplasia"),
    Medicine(name: "Ceftriaxone", details: "Antibiotic for bacterial infections"),
    Medicine(name: "Dapsone", details: "For leprosy and dermatitis herpetiformis"),
    Medicine(name: "Cefadroxil", details: "Antibiotic for bacterial infections"),
    Medicine(name: "Tretinoin", details: "Topical retinoid for acne"),
    Medicine(name: "Thyroxine", details: "Thyroid hormone replacement therapy"),
    Medicine(name: "Hydroxyzine", details: "Antihistamine for anxiety and allergies"),
    Medicine(name: "Vitamin B12", details: "Vitamin supplement"),
    Medicine(name: "Chlorthalidone", details: "Diuretic for hypertension and edema"),
    Medicine(name: "Duloxetine + Methylcobalamin", details: "Combination for neuropathic pain"),
    Medicine(name: "Cefadroxil", details: "Antibiotic for bacterial infections"),
    Medicine(name: "Metformin + Pioglitazone", details: "Combination for type 2 diabetes"),
    Medicine(name: "Cilnidipine", details: "Calcium channel blocker for high blood pressure"),
    Medicine(name: "Piracetam", details: "Nootropic medication"),
    Medicine(name: "Azilsartan", details: "For high blood pressure"),
    Medicine(name: "Moxifloxacin", details: "Antibiotic for bacterial infections"),
    Medicine(name: "Doxepin", details: "Tricyclic antidepressant"),
    Medicine(name: "Loratadine", details: "Antihistamine for allergies"),
    Medicine(name: "Methylcobalamin", details: "Vitamin supplement"),
    Medicine(name: "Desogestrel + Ethinyl Estradiol", details: "Combined oral contraceptive pill"),
    Medicine(name: "Cephadroxil", details: "Antibiotic for bacterial infections"),
    Medicine(name: "Mefenamic Acid", details: "Nonsteroidal anti-inflammatory drug (NSAID)"),
    Medicine(name: "Albendazole", details: "Anthelmintic medication for worm infections"),
    Medicine(name: "Ticagrelor", details: "Antiplatelet agent for preventing blood clots"),
    Medicine(name: "Guaifenesin", details: "Expectorant for cough and chest congestion"),
    Medicine(name: "Ciprofloxacin + Tinidazole", details: "Combination for bacterial infections"),
    Medicine(name: "Tizanidine", details: "Muscle relaxant for spasticity"),
    Medicine(name: "Ethambutol", details: "For tuberculosis"),
    Medicine(name: "Acarbose", details: "For type 2 diabetes"),
    Medicine(name: "Methotrexate", details: "For rheumatoid arthritis and cancer"),
    Medicine(name: "Nebivolol", details: "Beta blocker for high blood pressure"),
    Medicine(name: "Clotrimazole + Beclomethasone", details: "Combination for fungal infections"),
    Medicine(name: "Salmeterol + Fluticasone", details: "Combination for asthma and COPD"),
    Medicine(name: "Labetalol", details: "Beta blocker for high blood pressure"),
    Medicine(name: "Lamotrigine", details: "Anticonvulsant for epilepsy and bipolar disorder"),
    Medicine(name: "Nifedipine (sublingual)", details: "For angina"),
    Medicine(name: "Melatonin", details: "For sleep disorders"),
    Medicine(name: "Phenytoin", details: "Anticonvulsant for epilepsy"),
    Medicine(name: "Olanzapine", details: "Atypical antipsychotic"),
    Medicine(name: "Nortriptyline", details: "Tricyclic antidepressant"),
    Medicine(name: "Naloxone", details: "Opioid antagonist for overdose reversal"),
    Medicine(name: "Mirtazapine", details: "Atypical antidepressant"),
    Medicine(name: "Metronidazole (vaginal)", details: "For bacterial vaginosis"),
    Medicine(name: "Isosorbide Dinitrate", details: "For angina"),
    Medicine(name: "Indapamide", details: "Diuretic for hypertension and edema"),
    Medicine(name: "Fluconazole", details: "Antifungal medication"),
    Medicine(name: "Diltiazem", details: "Calcium channel blocker for high blood pressure and angina"),
    Medicine(name: "Cephalexin", details: "Antibiotic for bacterial infections"),
    Medicine(name: "Bisoprolol", details: "Beta blocker for high blood pressure and heart failure"),
    Medicine(name: "Artemether + Lumefantrine", details: "Antimalarial medication"),
    Medicine(name: "Tiotropium", details: "Long-acting bronchodilator for COPD"),
    Medicine(name: "Sodium Valproate", details: "Anticonvulsant for epilepsy"),
    Medicine(name: "Levocetirizine", details: "Antihistamine for allergies"),
    Medicine(name: "Doxazosin", details: "Alpha blocker for high blood pressure and benign prostatic hyperplasia"),
    Medicine(name: "Clotrimazole + Betamethasone", details: "Combination for fungal infections"),
    Medicine(name: "Cefixime", details: "Antibiotic for bacterial infections"),
    Medicine(name: "Azelastine", details: "Antihistamine for allergies"),
    Medicine(name: "Gatifloxacin", details: "Antibiotic for bacterial infections"),
    Medicine(name: "Ivermectin", details: "Antiparasitic medication"),
    Medicine(name: "Dicyclomine", details: "Antispasmodic for irritable bowel syndrome"),
    Medicine(name: "Levofloxacin + Ornidazole", details: "Combination for bacterial infections"),
    Medicine(name: "Doxycycline + Lactic Acid Bacillus", details: "Combination for bacterial infections"),
    Medicine(name: "Hydroxyzine", details: "Antihistamine for anxiety and allergies"),
    Medicine(name: "Chloroquine", details: "Antimalarial medication"),
    Medicine(name: "Sodium Bicarbonate", details: "For acidity and heartburn"),
    Medicine(name: "Phenobarbital", details: "Anticonvulsant and sedative"),
    Medicine(name: "Mebendazole", details: "Anthelmintic medication for worm infections"),
    Medicine(name: "Sodium Valproate", details: "Anticonvulsant for epilepsy"),
    Medicine(name: "Acitretin", details: "For psoriasis"),
    Medicine(name: "Calcium Carbonate", details: "Calcium supplement"),
    Medicine(name: "Phenazopyridine", details: "For urinary tract pain and discomfort"),
    Medicine(name: "Bimatoprost", details: "For glaucoma and hypotrichosis"),
    Medicine(name: "Hydroquinone", details: "For skin lightening and hyperpigmentation"),
    Medicine(name: "Tretinoin + Clindamycin", details: "Combination for acne"),
    Medicine(name: "Minoxidil", details: "For hair loss"),
    Medicine(name: "Tranexamic Acid", details: "For heavy menstrual bleeding and melasma"),
    Medicine(name: "Sildenafil", details: "For erectile dysfunction"),
    Medicine(name: "Finasteride", details: "For benign prostatic hyperplasia and male pattern baldness"),
    Medicine(name: "Acyclovir", details: "Antiviral medication for herpes infections"),
    Medicine(name: "Sodium Fusidate", details: "Topical antibiotic for skin infections"),
    Medicine(name: "Desonide", details: "Topical corticosteroid for skin inflammation"),
    Medicine(name: "Eflornithine", details: "For facial hair removal"),
    Medicine(name: "Latanoprost", details: "For glaucoma and ocular hypertension"),
    Medicine(name: "Mometasone", details: "Topical corticosteroid for skin inflammation"),
    Medicine(name: "Clobetasol", details: "Topical corticosteroid for skin inflammation"),
    Medicine(name: "Fluocinonide", details: "Topical corticosteroid for skin inflammation"),
    Medicine(name: "Silver Sulfadiazine", details: "Topical antibiotic for burns and wound infections"),
    Medicine(name: "Tacrolimus", details: "Topical immunosuppressant for eczema and psoriasis"),
    Medicine(name: "Clotrimazole + Beclomethasone", details: "Combination for fungal infections"),
    Medicine(name: "Miconazole", details: "Antifungal medication"),
    Medicine(name: "Ketoconazole", details: "Antifungal medication"),
    Medicine(name: "Econazole", details: "Antifungal medication"),
    Medicine(name: "Ciclopirox", details: "Antifungal medication"),
    Medicine(name: "Terbinafine", details: "Antifungal medication"),
    Medicine(name: "Griseofulvin", details: "Antifungal medication"),
    Medicine(name: "Hydrocortisone + Clotrimazole", details: "Combination for fungal infections"),
    Medicine(name: "Betamethasone + Gentamicin", details: "Combination for bacterial and fungal infections"),
    Medicine(name: "Beclomethasone + Clotrimazole + Neomycin", details: "Combination for fungal and bacterial infections"),
    Medicine(name: "Mometasone + Fusidic Acid", details: "Combination for bacterial infections and skin inflammation"),
    Medicine(name: "Fluocinolone + Neomycin + Nystatin + Clotrimazole", details: "Combination for various skin infections and inflammation"),
    Medicine(name: "Methamphetamine", details: "For narcolepsy and attention deficit hyperactivity disorder (ADHD)"),
]

