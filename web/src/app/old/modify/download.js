import Link from "next/link";

export default function Download(props) {
  if (!props.predictions.length) return null;

  const lastPrediction = props.predictions[props.predictions.length - 1];

  if (!lastPrediction.output) return null;

  const lastImage = lastPrediction.output[lastPrediction.output.length - 1];

  return (
    <Link
      href={lastImage}
      className="lil-button"
      target="_blank"
      rel="noopener noreferrer"
    >
      Download
    </Link>
  );
}
